require 'cocoapods-core'
require 'octokit'

module Cocoatree
  class Pods
    attr_reader :source

    def source_path=source_path
      @source = Pod::Source.new(source_path)
    end

    def repository name
      if spec_set = source.set(name)
        spec_set.specification.source[:git]
      end
    end
  end
end
