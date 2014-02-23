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
  task :clone do
    sh "rm -rf #{repo}"
    sh "#{git_cmd} clone git@github.com:cocoa-tree/#{repo}.git"
  end

  desc 'Provision target repository with content of tmp/public'
  task :provision do
    sh "rm -rf #{repo}/*"
    sh "mv -f tmp/public/* #{repo}/"
    Dir.chdir(repo) do
      sh "#{git_cmd} add --all ."
    end
  end
  
  desc 'Push to target repository'
  task :push do
    Dir.chdir(repo) do
      sh "#{git_cmd} commit -m \"Deploy.\" && #{git_cmd} push --force origin master"
    end
  end
end

desc 'Render and export Site to website-deploy'
task :deploy => ['deploy:clone',
                 'deploy:extract',
                 'deploy:provision',
                 'deploy:push']
