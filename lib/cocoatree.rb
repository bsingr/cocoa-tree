require "cocoatree/version"

module Cocoatree
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end
end
