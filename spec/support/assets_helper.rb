module AssetsHelper
  def assets_path *parts
    File.join(File.dirname(__FILE__), '..', 'assets', *parts)
  end
end

RSpec.configure do |config|
  config.include AssetsHelper
end
