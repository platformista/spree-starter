Sidekiq.strict_args!(:warn) # https://github.com/sidekiq/sidekiq/blob/main/docs/7.0-Upgrade.md#strict-arguments

# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end