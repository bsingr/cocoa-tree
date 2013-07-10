require "cocoatree/version"
require "cocoatree/pods"
require "cocoatree/website"
require "cocoatree/cache"

module Cocoatree
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end

  def self.github_cache
    @github_cache ||= Cache.new 'github_cache'
  end
end
