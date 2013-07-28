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
      data = fetch_github_repository_data
      data['watchers_count'] if data
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
