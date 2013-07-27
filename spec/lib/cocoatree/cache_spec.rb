require 'spec_helper'
require 'cocoatree/cache'

describe Cocoatree::Cache do
  before do
    Cocoatree.stub(:root).and_return(assets_path)
  end

  subject('cache') { described_class.new 'example_cache' }

  before do
    File.delete subject.path if File.exists? subject.path
  end

  its(:path) { should include('example_cache') }

  it 'fetches once' do
    result = cache.fetch('exampleId', 'exampleAttrName') do
      {'exampleAttrName' => 'exampleData'}
    end
    result.should == 'exampleData'
    second_result = cache.fetch('exampleId', 'exampleAttrName') do
      {'exampleAttrName' => 'newExampleData'}
    end
    second_result.should == 'exampleData'
  end
end
