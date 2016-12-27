require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails5Api
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.middleware.use Rack::Attack

    config.autoload_paths += [
      "#{config.root}/app/models/remote_db",
    ]

    ########## For Batch API ##########

    config.middleware.use BatchApi::RackMiddleware do |batch_config|
      # you can set various configuration options:
      batch_config.verb = :post # default :post
      batch_config.endpoint = "/batch" # default /batch
      batch_config.limit = 100 # how many operations max per request, default 50

      # default middleware stack run for each batch request
      batch_config.batch_middleware = Proc.new { }
      # default middleware stack run for each individual operation
      batch_config.operation_middleware = Proc.new { }
    end


  end
end
