class SeedsProxy < Rack::Proxy
  USE = ENV['SEEDS'] || 'remote'
  LOCAL_URL = 'localhost:3001'
  REMOTE_URL = 'cocoa-tree.github.io:80'

  if USE == 'local'
    puts "=> Using seeds from #{LOCAL_URL}"
  else
    puts "=> Using seeds from #{REMOTE_URL}"
  end

  def rewrite_env(env)
    if USE == 'remote'
      env["HTTP_HOST"] = REMOTE_URL
    else
      env["HTTP_HOST"] = LOCAL_URL
      env["SCRIPT_NAME"] = env["SCRIPT_NAME"].gsub("/seeds", "")
      env["REQUEST_URI"] = env["REQUEST_URI"].gsub("/seeds", "")
    end
    env
  end
end
