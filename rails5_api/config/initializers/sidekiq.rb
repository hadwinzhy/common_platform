require 'sidekiq'

redis_host = ENV['REDIS_HOST'] || '0.0.0.0'
redis_port = ENV['REDIS_PORT'] || 6379
redis_db_num = ENV['REDIS_DB_NUM'] || 0
#redis_namespace = Rails.application.secrets.redis_namespace

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/#{redis_db_num}"}
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/#{redis_db_num}"}
end

Sidekiq::Logging.logger.level = Logger::INFO
