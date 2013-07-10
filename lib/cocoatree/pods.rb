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

    def by_stars
      source.pods[0..50].map{|p| self.repository(p) }.compact.sort_by(&:stars)
    end

    class Repository
      attr_reader :url

      def initialize url
        @url = url
      end

      def github?
        !github_data.empty?
      end

      def github
        github_data.join '/'
      end

      def stars
        Octokit.stargazers(github).size
      rescue Octokit::NotFound => e
        -1
      end

    private

      def github_data
        matchdata = /github.com\/(.+)\/(.+).git/.match url
        raise "broken #{url}" unless matchdata
        matchdata.captures
      end
    end
  end
end
