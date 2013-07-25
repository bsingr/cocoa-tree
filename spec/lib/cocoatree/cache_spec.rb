require 'spec_helper'
require 'cocoatree/cache'

describe Cocoatree::Cache do
  before do
    Cocoatree.stub(:root).and_return(assets_path)
  end

  subject('cache') { described_class.new 'example_cache' }

  its(:path) { should include('example_cache') }
end
