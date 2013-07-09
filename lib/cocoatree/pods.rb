require 'cocoapods-core'
require 'octokit'

module Cocoatree
  class Pods
    attr_reader :source

    def source_path=source_path
      @source = Pod::Source.new(source_path)
    end


  end
end
