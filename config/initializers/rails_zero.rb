require 'rails_zero/drivers/poltergeist'

RailsZero.configure do |c|
  c.backend.url = 'http://cocoatree.herokuapp.com' if Rails.env.production?
  c.site.add_path '/'
  c.deployment.url = 'git@github.com:cocoa-tree/cocoa-tree.github.io.git'
end
