require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails4TwitterClone
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

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.action_controller.allow_forgery_protection = false

    # Support logstash-friendly logging
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Logstash.new
    config.lograge.custom_options = lambda do |event|
      params = event.payload[:params].reject do |k|
        ['controller', 'action'].include? k
      end

      { "params" => params }
    end

    config.log_level = :debug

    config.autoflush_log = true

    if ENV.has_key?("CONSUL_URL")
      Diplomat.configure do |config|
        config.url = ENV["CONSUL_URL"]
      end

      config.active_record.logger = nil

      # Configure Logstash URL from Consul
      logstash_service = Diplomat::Service.get('logstash')

      config.logstash.host = logstash_service.ServiceAddress
      config.logstash.port = logstash_service.ServicePort
      config.logstash.type = :tcp

      puts("Connecting to logstash with config: #{config.logstash}")
    end
  end
end
