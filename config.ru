require 'bundler/setup'

module ArtversityServer
  Bundler.require :default

  class Base < Sinatra::Base
    register Sinatra::ConfigFile
    config_file 'config.yml'

    set :environment, settings.environment
    set :protection, except: [:json_csrf]

    # Call Bundle.require for each environment
    settings.environments.each do |environment|
      configure environment do
        Bundler.require environment
      end
    end

    configure :development do
      register Sinatra::Reloader

      db_host     = settings.development['db_host']
      db_name     = settings.development['db_name']
      db_user     = settings.development['db_user']

      DB = Sequel.postgres(db_name,
                           host: db_host,
                           user: db_user)
    end

    configure :production do
      disable :show_exceptions

      db_host     = settings.production['db_host']
      db_name     = settings.production['db_name']
      db_user     = settings.production['db_user']
      db_password = settings.production['db_password']

      DB = Sequel.postgres(db_name,
                           host: db_host,
                           user: db_user,
                           password: db_password)
    end
  end
end

Sequel::Model.plugin :validation_helpers
Dir['./{controllers,models}/**/*.rb'].each { |file| require file }

map('/types') { run ArtversityServer::TypeController }
map('/performances') { run ArtversityServer::PerformancesController }
