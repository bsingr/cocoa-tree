class UpdateCocoaPodFromGithubJob
  def run
    github_updater = GithubUpdater.new
    CocoaPod.all.each do |cocoa_pod|
      github_updater.update cocoa_pod
    end
  end
end
