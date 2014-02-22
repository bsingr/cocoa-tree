desc "deploy to cocoatree-site"
task :deploy => :render do
  sh "rm -rf website-deploy/*"
  sh "cp -R public/* website-deploy/"
  sh "pushd website-deploy && git add . && git commit -m 'Deploy Site.' && git push origin gh-pages"
end
