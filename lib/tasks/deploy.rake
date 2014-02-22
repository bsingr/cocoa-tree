namespace :deploy do
  folder = "cocoa-tree.github.io"

  desc 'Extract public.tar to tmp/public'
  task :extract do
    sh "rm -rf website-deploy/*"
    sh "tar -xf public.tar -C tmp"
  end

  desc 'Clone target repository'
  task :clone do
    sh "./bin/git-github clone git@github.com:cocoa-tree/cocoa-tree.github.io.git"
  end

  desc 'Provision target repository with content of tmp/public'
  task :provision do
    sh "pushd #{folder} && git rm -r . && popd"
    sh "mv -f tmp/public/* #{folder}"
    sh "pushd #{folder} && git add . && popd"
  end
  
  desc 'Push to target repository'
  task :push do
    sh "pushd #{folder} && git commit -m 'Deploy Site.' && git push origin gh-pages && popd"
  end
end

desc 'Render and export Site to website-deploy'
task :deploy => ['deploy:extract',
                 'deploy:clone',
                 'deploy:provision',
                 'deploy:push']
