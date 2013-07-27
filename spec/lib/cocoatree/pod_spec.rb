require 'spec_helper'
require 'cocoatree/pod'

describe Cocoatree::Pod do
  let('spec') do
    double('Spec').tap do |s|
      s.stub('source').and_return git: 'git-url'
    end
  end

  subject('pod') { described_class.new spec }

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
end
