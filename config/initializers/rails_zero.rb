require 'rails_zero/drivers/poltergeist'

RailsZero.configure do |c|
  c.site.add_path '/'
  c.deployment.url = 'git@github.com:cocoa-tree/cocoa-tree.github.io.git'
  c.deployment.git_binary = 'git'
end
