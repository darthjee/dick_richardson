# frozen_string_literal: true

redis_url = ENV['REDISCLOUD_URL'] || ENV['DICK_RICHARDSON_REDIS_URL']

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
