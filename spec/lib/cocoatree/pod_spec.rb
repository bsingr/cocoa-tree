require 'spec_helper'
require 'cocoatree/pod'
require 'octokit'

describe Cocoatree::Pod do
  let('spec') do
    double('Spec').tap do |s|
      s.stub('source').and_return git: 'git-url'
      s.stub('version').and_return '1.2.3'
    end
  end

  subject('pod') { described_class.new spec }

  its('source') { should == spec.source }

  its('version') { should == '1.2.3' }
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

  describe 'github api data' do
    let('github_cache') do
      double('GithubCache').tap do |c|
        c.stub('fetch') do |key, &block|
          {'watchers_count' => 1337,
           'pushed_at' => "2011-01-26T19:06:43Z"}
        end
      end
    end
    before do
      Cocoatree.stub('github_cache').and_return github_cache
    end

    its('stars') { should == 1337 }
    its('pushed_at.to_s') { should == '2011-01-01 00:00:00 +0100' }
    
    context 'not cached' do
      before do
        github_cache.stub('fetch') do |key, &block|
          block.call
        end
      end

      its('stars') { should == -1 }
      its('pushed_at') { should == nil }

      it 'calls octokit' do
        Octokit.should_receive('repository').with('')
        pod.stars
      end

      it 'calls octokit with success' do
        spec.source[:git] = 'https://github.com/dpree/cocoatree.git'
        Octokit.should_receive('repository').with('dpree/cocoatree')
        pod.stars
      end
    end
  end
end
