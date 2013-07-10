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
      source.pods[0..4]\
        .map { |p|
          begin
            self.pod(p)
          rescue Pod::DSLError => e
            nil
          end
        }\
        .compact\
        .keep_if(&:github?)
    end

    def by_stars
      pods.sort_by(&:stars)
    end

    class Pod
      attr_reader :spec

      def initialize spec
        @spec = spec
      end

      def method_missing method_name, *args
        if spec.respond_to? method_name
          spec.send(method_name, *args)
        end
      end

      def url
        spec.source[:git]
      end

      def github?
        !github_data.empty?
      end

      def github
        github_data.join '/'
      end

      def stars
        @stars ||= (fetch_stars || -1)
      end

    private

      def fetch_stars
        Octokit.stargazers(github).size
      rescue Octokit::NotFound => e
        nil
      end

      def github_data
        matchdata = /github.com\/(.+)\/(.+).git/.match url
        return [] unless matchdata
        matchdata.captures
      end
    end
  end
end
