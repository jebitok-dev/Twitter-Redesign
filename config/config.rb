require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TwitterRedesign
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.before_initialize do
      dev = File.join(Rails.root, 'config', 'config.yml')
      YAML.load(File.open(dev)).each do |key,value|
        ENV[key.to_s] = value
      end if File.exists?(dev)
    end

    client = Aws::DynamoDB::Client.new(
      region: Aws.config[:region],
      instance_profile_credentials_timeout: 5, # defaults to 1 second
      instance_profile_credentials_retries: 5, # defaults to 0 retries
    )

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
