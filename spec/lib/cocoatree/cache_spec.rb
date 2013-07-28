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
    result = cache.fetch('exampleKey') do
      1337
    end
    result.should == 1337
    second_result = cache.fetch('exampleKey') do
      42
    end
    second_result.should == 1337
  end

  it 'gets nothing' do
    cache.get('exampleKey').should == nil
  end

  it 'sets and gets' do
    cache.get('exampleKey').should == nil
    cache.set('exampleKey', 'foo').should be_true
    cache.get('exampleKey').should == 'foo'
  end

  context 'cached' do
    before do
      cache.stub('read').and_return 'exampleKey' => {
        'expires_at' => Time.now + 3600,
        'value' => 'someValue'
      }
    end

    it 'gets item' do
      cache.get('exampleKey').should == 'someValue'
    end
  end
end
