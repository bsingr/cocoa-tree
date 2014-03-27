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

    config.assets.precompile += %w[
      application.css
      application.js

      pods_sync_worker.js

      application/app_router.js
      application/pods_sync_worker_client.js
      pods_sync_worker/pods_loader_worker.js

      shared/pods_controller.js
      shared/pods_store.js
      shared/pods_loader.js
      shared/pods_filter.js
      shared/pods_filter_renderer.js
      shared/pods_list.js
      shared/pods_index.js
      shared/pods_navigation_renderer.js
      shared/pods_progress_bar.js
      shared/pods_renderer.js
      shared/pods_word_stats.js
      shared/logger.js

      *.png
    ]
  end
end
