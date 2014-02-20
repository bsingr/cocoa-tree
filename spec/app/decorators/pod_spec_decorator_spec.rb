require 'spec_helper'

describe PodSpecDecorator do
  let('pod_spec') do
    double('Spec').tap do |s|
      s.stub('source').and_return git: 'http://example.com/repo.git'
      s.stub('version').and_return '1.2.3'
      s.stub('homepage').and_return 'http://example.com'
      s.stub('name').and_return 'my-spec'
    end
  end
  before { subject.pod_spec = pod_spec }
  its('pod_spec') { should == pod_spec }
  its('name') { should == 'my-spec' }
  its('version') { should == '1.2.3' }
  its('source_url') { should == 'http://example.com/repo.git' }
  its('website_url') { should == 'http://example.com' }
  its('github') { should be_false }
  
  context 'github' do
    before do
      pod_spec.source[:git] = 'https://github.com/foo/bar.git'
    end
    
    its('source_url') { should == 'https://github.com/foo/bar.git' }
    its('github') { should == 'foo/bar' }
  end
end
