require 'spec_helper'
require 'cocoatree/pods'

describe Cocoatree::Pods do
  before do
    subject.source_path = File.join(PROJECT_ROOT, 'Specs')
  end

  let(:repository) do
    subject.repository subject.source.pods.first
  end
  let(:github) do
    matchdata = /github.com\/(\w+)\/([\w-]+)/.match repository
    matchdata.captures.join('/')
  end
  let(:stars) do
    Octokit.stargazers(github).size
  end

  it 'lists pods' do
    subject.source.pods.should_not be_empty
  end

  it 'shows single pod' do
    repository.should include('github')
  end

  it 'extracts github' do
    github.should == '500px/500px-iOS-api'
  end

  it 'counts stars' do
    stars.should > 1
  end
end
