class Remote
  def initialize
    require 'capybara/dsl'
    require 'capybara/poltergeist'
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:timeout => 120})
    end
    Capybara.javascript_driver = :poltergeist
    Capybara.default_driver = :poltergeist
    if Rails.env.development?
      Capybara.app_host = 'http://localhost:3000'
    else
      Capybara.app_host = 'http://cocoatree.herokuapp.com'
    end
  end
  
  def clear
    Capybara.visit '/deploys/clear'
  end
  
  def download
    system "curl #{Capybara.app_host}/deploys > public.tar"
  end
  
  def render
    Capybara.visit '/pods'
  end
end

namespace :site do
  desc 'Clear Cache'
  task :clear => :environment do
    Remote.new.clear
  end
  
  desc 'Render Site'
  task :render => :environment do
    Remote.new.render
  end
  
  desc 'Download Site'
  task :download => :environment do
    Remote.new.download
  end
end

desc 'Render and Download Site'
task :site => ['site:clear', 'site:render', 'site:download']
