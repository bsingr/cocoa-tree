namespace :jobs do
  desc 'Sync Spec'
  task :sync_spec => :environment do
    UpdateCocoaPodFromPodSpecJob.new.run
  end
  
  desc 'Sync Github'
  task :sync_github => :environment do
    UpdateCocoaPodFromGithubJob.new.run
  end
end
