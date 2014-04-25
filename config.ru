require 'rubygems'
require 'date'
require 'bundler/setup'
require 'json'

module ArtversityServer
  Bundler.require :default

  class Base < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config.yml'

    set :environment, settings.environment

    enable :sessions

    # call Bundle.require for each environment
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

Dir['./{controllers}/**/*.rb'].each { |file| require file }

run ArtversityServer::ApplciationController
