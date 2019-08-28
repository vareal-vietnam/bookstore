require_relative 'application'

Rails.application.initialize!
Rails.application.routes.default_url_options[:host] = ENV['HOST_URL']
