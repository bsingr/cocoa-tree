desc 'Deploy the site'
task :deploy => ['rails_zero:generate', 'rails_zero:deploy:git']
