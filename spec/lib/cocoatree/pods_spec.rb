require 'spec_helper'
require 'cocoatree/pods'

describe Cocoatree::Pods do
  before do
    subject.source_path = File.join(PROJECT_ROOT, 'Specs')
  end

  let(:repository) do
    subject.repository subject.source.pods.first
  end

  it 'lists pods' do
    subject.source.pods.should_not be_empty
  end

  it 'shows single pod' do
    repository.should be_github
  end

  it 'extracts github' do
    repository.github.should == '500px/500px-iOS-api'
  end

  it 'counts stars' do
    repository.stars.should > 1
  end
end
