require 'spec_helper'
require 'cocoatree/pod'
require 'octokit'

describe Cocoatree::Pod do
  let('spec') do
    double('Spec').tap do |s|
      s.stub('source').and_return git: 'git-url'
    end
  end

  subject('pod') { described_class.new spec }

  its('source') { should == spec.source }

  its('url') { should == 'git-url' }
  its('github') { should == '' }
  its('github?') { should be_false }

  context 'github' do
    before do
      spec.source[:git] = 'https://github.com/foo/bar.git'
    end
  
    its('url') { should == 'https://github.com/foo/bar.git' }
    its('github') { should == 'foo/bar' }
    its('github') { should be_true}
  end

  describe 'stars' do
    let('github_cache') do
      double('GithubCache').tap do |c|
        c.stub('fetch') do |id, key, &block|
          1337
        end
      end
    end
    before do
      Cocoatree.stub('github_cache').and_return github_cache
    end

    its('stars') { should == 1337 }

    context 'not cached' do
      before do
        github_cache.stub('fetch') do |id, key, &block|
          block.call
        end
      end

      its('stars') { should == -1 }
    end
  end
end