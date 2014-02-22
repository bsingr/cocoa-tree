namespace :deploy do
  repo = "cocoa-tree.github.io"
  git_cmd = ENV.has_key?('GITHUB_SSH') ? './bin/git-github' : 'git'

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
    sh "pushd #{repo} && #{git_cmd} add --all . && popd"
  end
  
  desc 'Push to target repository'
  task :push do
    sh "pushd #{repo} && #{git_cmd} commit -m 'Deploy Site.' && #{git_cmd} push --force origin master && popd"
  end
end

desc 'Render and export Site to website-deploy'
task :deploy => ['deploy:clone',
                 'deploy:extract',
                 'deploy:provision',
                 'deploy:push']
