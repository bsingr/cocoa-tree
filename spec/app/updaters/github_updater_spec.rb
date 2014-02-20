require 'spec_helper'

describe GithubUpdater do
  subject(:updater) { described_class.new }
  let('cocoa_pod') do
    CocoaPod.new source_url: 'https://github.com/dpree/cocoatree.git'
  end
  
  it 'calls Octokit.repository' do
    Octokit.should_receive('repository').with('dpree/cocoatree')
    subject.update cocoa_pod
  end
  
  describe 'updated cocoa_pod' do
    subject { cocoa_pod }
    before do
      Octokit.stub('repository') do
        {'watchers_count' => 1337,
         'pushed_at' => "2011-01-26T19:06:43Z"}
      end
    end
    before { updater.update cocoa_pod }
    
    its('stars') { should == 1337 }
    its('pushed_at.to_s') { should == "2011-01-26 19:06:43 UTC"}
  end
end
