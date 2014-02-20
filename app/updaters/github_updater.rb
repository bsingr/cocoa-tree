class GithubUpdater
  def update cocoa_pod
    if repository = extract_repository(cocoa_pod.source_url)
      if data = get_github_repository(repository)
         cocoa_pod.pushed_at = data['pushed_at']
         cocoa_pod.stars = data['watchers_count']
         cocoa_pod.save!
      end
    end
  end
  
  def extract_repository url
    matchdata = /github.com\/(.+)\/(.+).git/.match url
    return [] unless matchdata
    matchdata.captures.join('/')
  end
  
  def get_github_repository repository
    Octokit.repository(repository)
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
