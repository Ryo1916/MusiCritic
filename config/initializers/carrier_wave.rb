# frozen_string_literal: true

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'fog/aws',
      region: Rails.application.secrets.region,
      aws_access_key_id: Rails.application.secrets.access_key_id,
      aws_secret_access_key: Rails.application.secrets.secret_access_key
    }
    config.fog_directory = Rails.application.secrets.bucket
    config.asset_host = "https://s3-#{Rails.application.secrets.region}.amazonaws.com/#{Rails.application.secrets.bucket}"
  end
end
