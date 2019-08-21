# frozen_string_literal: true

if Rails.env.production?
  Rails.application.config.session_store :redis_store, {
    servers: ENV['REDIS_URL'],
    expire_after: 90.minutes,
    key: "_#{Rails.application.class.parent_name.downcase}_session"
  }
else
  Rails.application.config.session_store :redis_store, {
    servers: [
     { host: ENV['REDIS_HOST'] || 'redis',
       port: ENV['REDIS_PORT'] || 6379,
       db: 0,
       namespace: 'session' }
    ],
    expire_after: 90.minutes,
    key: "_#{Rails.application.class.parent_name.downcase}_session"
  }
end
