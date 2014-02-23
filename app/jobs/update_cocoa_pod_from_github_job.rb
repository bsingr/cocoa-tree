class UpdateCocoaPodFromGithubJob
  def run
    github_updater = GithubUpdater.new
    CocoaPod.all.find_each do |cocoa_pod|
      if Time.now > (cocoa_pod.updated_at + 1.day) || !cocoa_pod.pushed_at
        Rails.logger.info "sync github #{cocoa_pod.name}"
        github_updater.update cocoa_pod
      end
    end
  end
end
