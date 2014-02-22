namespace :deploy do
  desc 'Extract public.tar to website-deploy'
  task :extract do
    sh "rm -rf website-deploy/*"
    sh "pushd website-deploy && git rm -r . && popd"
    sh "tar -xf public.tar -C tmp"
    sh "mv -f tmp/public/* website-deploy"
    sh "pushd website-deploy && git add . && popd"
  end
  
  desc 'Push website-deploy submodule'
  task :push do
    sh "pushd website-deploy && git commit -m 'Deploy Site.' && git push origin gh-pages && popd"
  end
end

desc 'Render and export Site to website-deploy'
task :deploy => ['deploy:extract', 'deploy:push']
