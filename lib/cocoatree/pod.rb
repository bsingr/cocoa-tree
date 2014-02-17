require 'time'

module Cocoatree
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

    def version
      spec.version
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
      ensure_data
      @data['watchers_count'] || -1
    end

    def pushed_at
      ensure_data
      time = @data['pushed_at']
      if time.kind_of? Time
        time
      elsif time.kind_of? String
        Time.parse(time)
      else
        nil
      end
    end

    def doc_url
      "http://cocoadocs.org/docsets/#{name}/#{version}"
    end
    
    def serializable_hash
      {using_github: github?,
       doc_url: doc_url,
       website_url: homepage,
       version: version,
       source_url: url}
    end

  private

    def ensure_data
      @data ||= (fetch_github_repository_data || {})
    end

    def github_data
      matchdata = /github.com\/(.+)\/(.+).git/.match url
      return [] unless matchdata
      matchdata.captures
    end

    def fetch_github_repository_data
      Cocoatree.github_cache.fetch(github) do
        Octokit.repository(github)
      end
    rescue  Octokit::BadRequest,
            Octokit::Unauthorized,
            Octokit::Forbidden,
            Octokit::NotFound,
            Octokit::NotAcceptable,
            Octokit::UnprocessableEntity,
            Octokit::InternalServerError,
            Octokit::NotImplemented,
            Octokit::BadGateway,
            Octokit::ServiceUnavailable => e
      p e
      nil
    end
  end
end
