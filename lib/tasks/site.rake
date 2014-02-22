class Remote
  def initialize
    require 'capybara/dsl'
    require 'capybara/poltergeist'
    Capybara.javascript_driver = :poltergeist
    Capybara.default_driver = :poltergeist
    Capybara.app_host = 'http://localhost:3000'
  end
  
  def clear
    Capybara.visit '/deploys/clear'
  end
  
  def download
    Capybara.visit '/deploys'
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
