github_conf_file = Rails.root.join('config', 'github.yml')
if File.exists?(github_conf_file)
  puts "Detected #{github_conf_file}"
  github_config = YAML.load_file(github_conf_file)
  puts "Using github login = #{github_config['login']}"
  Octokit.configure do |c|
    c.login = github_config['login']
    c.access_token = github_config['access_token']
  end
elsif ENV.has_key?('GITHUB_LOGIN') && ENV.has_key?('GITHUB_TOKEN')
  puts "Detected GITHUB_LOGIN and GITHUB_TOKEN"
  puts "Using github login = #{ENV['GITHUB_LOGIN']}"
  Octokit.configure do |c|
    c.login = ENV['GITHUB_LOGIN']
    c.access_token = ENV['GITHUB_TOKEN']
  end
end
