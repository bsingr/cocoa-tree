require 'spec_helper'

describe PodSpecDecorator do
  let('pod_spec') do
    double('Spec').tap do |s|
      s.stub('source').and_return git: 'git-url'
      s.stub('version').and_return '1.2.3'
      s.stub('homepage').and_return 'http://example.com'
      s.stub('name').and_return 'my-spec'
    end
  end
  before { subject.pod_spec = pod_spec }
  its('pod_spec') { should == pod_spec }
  its('name') { should == 'my-spec' }
  its('version') { should == '1.2.3' }
  its('source_url') { should == 'git-url' }
  its('website_url') { should == 'http://example.com' }
end
