# frozen_string_literal: true

Rails.application.config.session_store :redis_store,
  servers: [
   { host: ENV['REDIS_HOST'] || '127.0.0.1',
     port: ENV['REDIS_PORT'] || 6379,
     db: 0,
     namespace: 'session' }
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.parent_name.downcase}_session"
