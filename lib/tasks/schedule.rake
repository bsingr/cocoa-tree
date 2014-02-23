desc 'Run jobs to update database and then render and deploy the site'
task :schedule => [:jobs, :site, :deploy]
