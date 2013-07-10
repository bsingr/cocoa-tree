require "cocoatree/version"
require "cocoatree/pods"
require "cocoatree/website"

module Cocoatree
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end
end
