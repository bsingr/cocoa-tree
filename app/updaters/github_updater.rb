class GithubUpdater
  def update cocoa_pod
    if repository = GithubUrl.new.shortcut(cocoa_pod.source_url)
      if data = get_github_repository(repository)
         cocoa_pod.pushed_at = data['pushed_at']
         cocoa_pod.stars = data['watchers_count']
         cocoa_pod.save!
      end
    end
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
