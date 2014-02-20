class UpdateCocoaPodFromGithubJob
  def run
    github_updater = GithubUpdater.new
    CocoaPod.all.find_each do |cocoa_pod|
      puts "sync github #{cocoa_pod.name}"
      github_updater.update cocoa_pod
    end
  end
end
