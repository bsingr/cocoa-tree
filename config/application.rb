require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Cocoatree
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.precompile << 'application.js'
    config.assets.precompile << 'pods_sync_worker.js'
    
    config.assets.precompile << 'application/app_router.js'
    config.assets.precompile << 'application/pods_sync_worker_client.js'
    config.assets.precompile << 'pods_sync_worker/pods_loader_worker.js'

    config.assets.precompile << 'pods/pods_controller.js'
    config.assets.precompile << 'pods/pods_store.js'
    config.assets.precompile << 'pods/pods_loader.js'
    config.assets.precompile << 'pods/pods_filter.js'
    config.assets.precompile << 'pods/pods_filter_renderer.js'
    config.assets.precompile << 'pods/pods_list.js'
    config.assets.precompile << 'pods/pods_index.js'
    config.assets.precompile << 'pods/pods_navigation_renderer.js'
    config.assets.precompile << 'pods/pods_progress_bar.js'
    config.assets.precompile << 'pods/pods_renderer.js'
    config.assets.precompile << 'pods/pods_word_stats.js'
    
    config.assets.precompile << 'lib/logger.js'
  end
end
