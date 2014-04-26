require 'bundler/setup'

module ArtversityServer
  Bundler.require :default

  class Base < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config.yml'

    set :environment, settings.environment

    enable :sessions

    # Call Bundle.require for each environment
    settings.environments.each do |environment|
      configure environment do
        Bundler.require environment
      end
    end

    configure :development do
      register Sinatra::Reloader
    end

    configure :production do
      disable :show_exceptions
    end
  end
end

Sequel::Model.plugin :validation_helpers
Dir['./{controllers,models}/**/*.rb'].each { |file| require file }

run ArtversityServer::ApplciationController
