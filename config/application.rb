require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MusiCritic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set default time zone
    config.time_zone = 'Tokyo'

    # To include apis modules in this app
    config.autoload_paths += %W(#{config.root}/apis)

    # Not to display <div class="field_with_errors">
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      %Q(#{html_tag}).html_safe
    end

    # Use slim as a template engine
    config.generators.template_engine = :slim

    # Don't generate routes, system test files, stylesheets, javascripts.
    config.generators do |g|
      g.skip_routes false
      g.stylesheets false
      g.javascripts false
      g.system_tests false
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       routing_specs: false
    end
  end
end
