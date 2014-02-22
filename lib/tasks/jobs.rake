namespace :jobs do
  desc 'Sync Spec'
  task :spec => :environment do
    UpdateCocoaPodFromPodSpecJob.new.run
  end

  desc 'Sync Spec Dependencies'
  task :dependency => :environment do
    UpdateCocoaPodDependencyFromPodSpecJob.new.run
  end
  
  desc 'Sync Github'
  task :github => :environment do
    UpdateCocoaPodFromGithubJob.new.run
  end
end

desc 'All Jobs'
task :jobs => ['jobs:spec', 'jobs:dependency', 'jobs:github']
