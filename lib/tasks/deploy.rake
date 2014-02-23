namespace :deploy do
  repo = "cocoa-tree.github.io"
  root = File.join(File.dirname(__FILE__), '..', '..')
  git_cmd = ENV.has_key?('GITHUB_SSH') ? "#{root}/bin/git-github" : 'git'

  desc 'Extract public.tar to tmp/public'
  task :extract do
    sh "rm -rf tmp/public"
    sh "tar -xf public.tar -C tmp"
  end

  desc 'Clone target repository'
  task :prepare do
    sh "rm -rf #{repo}"
    sh "mkdir -p #{repo}"
  end

  desc 'Provision target repository with content of tmp/public'
  task :provision do
    sh "rm -rf #{repo}/*"
    sh "mv -f tmp/public/* #{repo}/"
  end
  
  desc 'Push to target repository'
  task :push do
    Dir.chdir(repo) do
      sh "#{git_cmd} init"
      sh "#{git_cmd} remote add origin git@github.com:cocoa-tree/#{repo}.git"
      sh "#{git_cmd} add --all ."
      sh "#{git_cmd} commit -m \"Deploy.\""
      sh "#{git_cmd} push -u --force origin master"
    end
  end
end

desc 'Render and export Site to website-deploy'
task :deploy => ['deploy:prepare',
                 'deploy:extract',
                 'deploy:provision',
                 'deploy:push']
