# frozen_string_literal: true

uri = URI.parse(ENV['REDIS_URL'])
Rails.application.config.session_store :redis_store, {
  servers: [
    {
      host: uri.host || 'redis',
      port: uri.port || 6379,
      db: 0,
      namespace: 'session'
    }
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
}
