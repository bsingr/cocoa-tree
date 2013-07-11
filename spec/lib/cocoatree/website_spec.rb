require 'spec_helper'
require 'cocoatree'

describe Cocoatree::Website do
  let(:website) { described_class.new }
  let(:pods) { Cocoatree::Pods.new }
  before do
    pods.source_path = File.join(Cocoatree.root, 'Specs')
    Octokit.stub(:stargazers) do
      Array.new(rand(100))
    end
  end

  it do
    website.pods = pods
    rendered = website.render('index.html')
    rendered.should include('<html>')
    rendered.should include('<li>')
  end
end
