require 'spec_helper'

describe CocoaPod do
  it { should have_many(:cocoa_pod_dependencies) }
  it { should have_many(:dependent_cocoa_pods) }
end
