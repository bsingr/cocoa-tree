require "bundler/gem_tasks"
require 'yaml'

lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoatree'

desc "build website"
task :site do
  github_config = YAML.load_file('github_config.yml')
  Octokit.configure do |c|
    c.login = github_config['login']
    c.oauth_token = github_config['oauth_token']
  end
  Cocoatree.github_cache.ignore_expiry!
  pods = Cocoatree::Pods.new
  pods.source_path = File.join(Cocoatree.root, 'Specs')
  website = Cocoatree::Website.new
  website.pods = pods
  rendered = website.render('index.html')
  File.open(File.join(Cocoatree.root, 'website', 'index.html'), 'w') do |f|
    f.puts rendered
  end
end

task :default => :spec
