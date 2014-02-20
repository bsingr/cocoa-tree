require 'spec_helper'

describe PodSpecIndex do
  before do
    subject.source_path = assets_path('example-pod-specs')
  end

  its(:pod_specs) { should_not be_empty }
  its('pod_specs.first.name') { should == '500px-iOS-api' }
end
