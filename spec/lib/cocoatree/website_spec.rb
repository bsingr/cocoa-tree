require 'spec_helper'
require 'cocoatree'

describe Cocoatree::Website do
  let(:website) { described_class.new }
  let(:pods) { Cocoatree::Pods.new }
  before do
    pods.source_path = assets_path('example-pod-specs')
    Cocoatree::Pod.any_instance.stub(:stars) do
      rand(100)
    end
  end

  it 'renders html' do
    website.pods = pods
    rendered = website.render('index.html')
    rendered.should include('<html>')
    rendered.should include('<div class="title">500px-iOS-api</div>')
  end
end
