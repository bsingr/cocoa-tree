require "bundler/gem_tasks"
require 'yaml'

lib = File.expand_path('lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoatree'

class SiteGenerator
  attr_accessor :mock

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
    if mock
      pod = Hashie::Mash.new name: "YetAnoPod",
                             spec: {
                              summary: "Yet Another Pod is a just another Pod."
                             },
                             stars: 1349,
                             url: 'http://wwww.example.com',
                             doc_url: 'http://doc.example.com',
                             wiki_url: 'http://wiki.example.com',
                             source_url: 'http://source.example.com',
                             pushed_at: Time.gm(Time.now.year, 06, 06),
                             category: 'Database Adapter',
                             platforms: %w[ios osx],
                             version: '3.0.9',
                             dependencies: [
                              {name: 'Ponderosa', requirement: '>= 0.5 < 0.7'},
                              {name: 'Meatballz', requirement: nil}
                             ]
      Hashie::Mash.new pods: [pod, pod, pod],
                       pods_by_stars: [pod, pod, pod]
    else
      pods = Cocoatree::Pods.new
      pods.source_path = File.join(Cocoatree.root, 'Specs')
      pods
    end
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
  generator = SiteGenerator.new
  generator.mock = true
  generator.generate!
  sh 'scss website/src/assets/stylesheets/* website/assets/css/style.css'
end

task :default => :spec
