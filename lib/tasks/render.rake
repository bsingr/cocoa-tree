desc 'Render Site'
task :render => :environment do
  require 'capybara/dsl'
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist
  Capybara.visit '/pods'
end
