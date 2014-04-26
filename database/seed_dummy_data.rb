require 'date'
require 'sequel'
require 'pg'
require 'yaml'

settings = YAML.load(File.open('config.yml'))

environment = settings['environment']
env_settings = settings[environment]

case environment
when 'development'
  db_host     = env_settings['db_host']
  db_name     = env_settings['db_name']
  db_user     = env_settings['db_user']

  DB = Sequel.postgres(db_name,
                       host: db_host,
                       user: db_user)
when 'production'
  db_host     = env_settings['db_host']
  db_name     = env_settings['db_name']
  db_user     = env_settings['db_user']
  db_password = env_settings['db_password']

  DB = Sequel.postgres(db_name,
                       host: db_host,
                       user: db_user,
                       password: db_password)
end

Sequel::Model.plugin :validation_helpers
Dir.glob('./models/*.rb').each { |file| require file }

tables = [
          'types',
          'categories',
          'performances',
          # 'medias',
         ]

tables.each do |table|
  puts "Populating dummy data into #{table}..."
  require "./database/dummy_data_packs/dummy_#{table}.rb"
  puts "done"
end
