require 'spec_helper'
require 'cocoatree/pod'
require 'cocoatree/pods'

describe Cocoatree::Pods do
  subject(:pods) { Cocoatree::Pods.new }
  before do
    pods.source_path = assets_path('example-pod-specs')
    Cocoatree::Pod.any_instance.stub(:stars) do
      rand(100)
    end
  end

  let(:pod) do
    subject.pod subject.source.pods.first
  end

  its(:pods) { should_not be_empty }

  its('pods.first.url') { should include('github.com') }
  its('pods.first') { should be_github }

  it 'shows name' do
    pod.name.should_not == ''
  end

  it 'shows single pod' do
    pod.should be_github
  end

  it 'extracts github' do
    pod.github.should == '500px/500px-iOS-api'
  end

  it 'counts stars' do
    pod.stars.should > 1
  end

  it 'sorts by stars' do
    by_stars = subject.pods_by_stars
    by_stars.first.stars.should > by_stars.last.stars
  end
end
