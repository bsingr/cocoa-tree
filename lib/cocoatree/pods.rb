require 'cocoapods-core'
require 'octokit'
module Cocoatree
  class Pods
    attr_reader :source

    def source_path=source_path
      @source = ::Pod::Source.new(source_path)
    end

    def pod name
      if spec_set = source.set(name)
        if url = spec_set.specification
          Pod.new(spec_set.specification)
        end
      end
    end

    def pods
      source.pods\
        .map { |p|
          begin
            self.pod(p)
          rescue ::Pod::DSLError => e
            nil
          end
        }\
        .compact\
        .keep_if(&:github?)
    end

    def pods_by_stars
      pods.sort_by(&:stars).reverse
    end
  end
end
