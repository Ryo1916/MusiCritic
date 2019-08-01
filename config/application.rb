require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MusicReview
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set default time zone
    config.time_zone = 'Tokyo'

    # To include apis modules in this app
    config.autoload_paths += %W(#{config.root}/apis)

    # Use secrets.yml for credentials
    config.read_encrypted_secrets = true

    # Not to display <div class="field_with_errors">
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end

    # Auth for rspotify
    RSpotify.authenticate(
      Rails.application.secrets.spotify_api_key,
      Rails.application.secrets.spotify_api_secret
    )
  end
end
