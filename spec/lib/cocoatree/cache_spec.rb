require 'spec_helper'
require 'cocoatree/cache'

describe Cocoatree::Cache do
  before do
    Cocoatree.stub(:root).and_return(assets_path)
  end

  subject('cache') { described_class.new 'example_cache' }

  its(:path) { should include('example_cache') }

  it 'fetches once' do
    result = cache.fetch('exampleId', 'exampleAttrName') do
      'exampleData'
    end
    result.should == 'exampleData'
    second_result = cache.fetch('exampleId', 'exampleAttrName') do
      'newExampleData'
    end
    second_result.should == 'exampleData'
  end
end
