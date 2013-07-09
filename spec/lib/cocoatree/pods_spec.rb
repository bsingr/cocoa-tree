require 'spec_helper'
require 'cocoatree'
require 'cocoapods-core'
require 'octokit'

describe Cocoatree do
  let(:source) { Pod::Source.new(File.join(PROJECT_ROOT, 'Specs')) }
  let(:repository) do
    spec_set = source.set(source.pods.first)
    spec_set.should_not be_nil
    spec_set.specification.source[:git]
  end
  let(:github) do
    matchdata = /github.com\/(\w+)\/([\w-]+)/.match repository
    matchdata.captures.join('/')
  end
  let(:stars) do
    Octokit.stargazers(github).size
  end

  it 'lists pods' do
    source.pods.should_not be_empty
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
