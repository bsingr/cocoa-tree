module AssetsHelper
  def assets_path *parts
    spec_root_path 'assets', *parts
  end
end

RSpec.configure do |config|
  config.include AssetsHelper
end
