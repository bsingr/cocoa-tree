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

    def repositories
      source.pods\
        .map { |p|
          begin
            self.repository(p)
          rescue Pod::DSLError => e
            nil
          end
        }\
        .compact\
        .keep_if(&:github?)
    end

    def by_stars
      repositories.sort_by(&:stars)
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
