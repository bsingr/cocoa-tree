module RootHelper
  def root_path *parts
    File.join(File.dirname(__FILE__), '..', '..', *parts)
  end

  def spec_root_path *parts
    root_path 'spec', *parts
  end
end

RSpec.configure do |config|
  config.include RootHelper
end
