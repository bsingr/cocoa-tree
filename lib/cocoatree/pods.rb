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
        if url = spec_set.specification.source[:git]
          Repository.new(url)
        end
      end
    end

    class Repository < Struct.new(:url)
      def github?
        !github_data.empty?
      end

      def github
        github_data.join '/'
      end

      def stars
        Octokit.stargazers(github).size
      end

    private

      def github_data
        matchdata = /github.com\/(\w+)\/([\w-]+)/.match url
        matchdata.captures
      end
    end
  end
end
