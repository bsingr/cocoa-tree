require "cocoatree/version"
require "cocoatree/pod"
require "cocoatree/pods"
require "cocoatree/website"
require "cocoatree/cache"
require "hashie"
require "logger"

module Cocoatree
  def self.root
    File.join(File.dirname(__FILE__), '..')
  end

  def self.github_cache
    @github_cache ||= Cache.new 'github_cache', Logger.new(STDOUT)
  end
end
