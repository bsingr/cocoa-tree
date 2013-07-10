require 'cocoapods-core'
require 'octokit'
require 'yaml'

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

      def github_cache
        hash = YAML.load_file('github_cache.yml')
        hash.is_a?(Hash) ? hash : {}
      rescue => e
        return {}
      end

      def github_cache=data
        File.open('github_cache.yml', 'w') {|f| f.puts YAML.dump(data)}
      end

      def fetch_stars
        cache = github_cache

        # try to read cache
        if cache_data = cache[github]
          if cache_data['expires_at'] > Time.now
            if stars_count = cache_data['stars_count']
              return stars_count
            end
          end
        end

        # fetch + update cache
        stars_count = Octokit.stargazers(github).size
        puts "CACHE SET #{github} {stars_count: #{stars_count}}"
        cache[github] ||= {}
        cache[github]['stars_count'] = stars_count
        cache[github]['expires_at'] = Time.now + 1*60*60*24
        self.github_cache = cache
        return stars_count
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
