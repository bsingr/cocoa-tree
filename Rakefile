require "bundler/gem_tasks"
require 'yaml'

lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoatree'

class SiteGenerator
  def initialize
    configure_github_cache
    configure_octokit
  end

  def configure_github_cache
    Cocoatree.github_cache.ignore_expiry!
    Cocoatree.github_cache.do_not_update_on_fetch!
  end

  def configure_octokit
    github_config = YAML.load_file('github_config.yml')
    Octokit.configure do |c|
      c.login = github_config['login']
      c.oauth_token = github_config['oauth_token']
    end
  end

  def build_pods
    pods = Cocoatree::Pods.new
    pods.source_path = File.join(Cocoatree.root, 'Specs')
    pods
  end

  def build_website
    website = Cocoatree::Website.new
    website.pods = build_pods
    website
  end

  def generate!
    rendered = build_website.render('index.html')
    File.open(File.join(Cocoatree.root, 'website', 'index.html'), 'w') do |f|
      f.puts rendered
    end
  end
end


desc "build website"
task :site do
  SiteGenerator.new.generate!
end

task :default => :spec
