# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      region: Rails.application.credentials[Rails.env.to_sym][:region],
      aws_access_key_id: Rails.application.credentials[Rails.env.to_sym][:access_key_id],
      aws_secret_access_key: Rails.application.credentials[Rails.env.to_sym][:secret_access_key]
    }
    config.fog_directory = Rails.application.credentials[Rails.env.to_sym][:bucket]
    config.asset_host = "https://s3-#{Rails.application.credentials[Rails.env.to_sym][:region]}.amazonaws.com/#{Rails.application.credentials[Rails.env.to_sym][:bucket]}"
  end
end
