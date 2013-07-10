require 'spec_helper'
require 'cocoatree/pods'

describe Cocoatree::Pods do
  subject(:pods) { Cocoatree::Pods.new }
  before do
    pods.source_path = File.join(Cocoatree.root, 'Specs')
    Octokit.stub(:stargazers) do
      Array.new(rand(100))
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
    first = subject.pods_by_stars.first
    last = subject.pods_by_stars.last
    first.stars.should > last.stars
  end
end
