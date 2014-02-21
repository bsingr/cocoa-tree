class GithubUpdater
  def update cocoa_pod
    if repository = GithubUrl.new.shortcut(cocoa_pod.source_url)
      if data = get_github_repository(repository)
         cocoa_pod.pushed_at = normalize_time(data['pushed_at'])
         cocoa_pod.stars = data['watchers_count'] || 0
         cocoa_pod.save!
      end
    end
  end
  
  def normalize_time time
    if time.kind_of? Time
      time
    elsif time.kind_of? String
      Time.parse(time)
    else
      nil
    end
  end
  
  def get_github_repository repository
    Octokit.repository(repository)
  rescue Octokit::TooManyRequests => e
    raise "STOP: Rate Limit Exceed #{e.inspect}"
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
