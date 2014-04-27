require 'sequel'
require 'yaml'

# Load config file
settings = YAML.load(File.open('config.yml'))

namespace :db do
  Sequel.extension :migration, :core_extensions

  migrator    = Sequel::Migrator
  migrations  = settings['migrations_path']
  environment = settings['environment']
  env_settngs = settings[environment]

  # Setup Database Connection
  case environment
  when 'development'
    db_host     = env_settngs['db_host']
    db_name     = env_settngs['db_name']
    db_user     = env_settngs['db_user']
    db_password = env_settngs['db_password']

    DB = Sequel.postgres(db_name,
                         host: db_host,
                         user: db_user, password: db_password)

  when 'production'
    db_host     = env_settngs['db_host']
    db_name     = env_settngs['db_name']
    db_user     = env_settngs['db_user']
    db_password = env_settngs['db_password']

    DB = Sequel.postgres(db_name,
                         host: db_host,
                         user: db_user,
                         password: db_password)
  end

  Sequel::Model.plugin :validation_helpers
  Dir.glob('./models/*.rb').each { |file| require file }

  desc 'Reverts all migrations.'
  task :drop do
    puts 'Reverting all migrations...'
    migrator.apply(DB, migrations, 0)
    puts 'Done!'
  end

  desc 'Migrates to newest migration.'
  task :migrate do
    puts 'Migrating to newest migration...'
    migrator.apply(DB, migrations)
    puts 'Done!'
  end

  desc 'Reverts all migrations and migrates to newest migrations.'
  task :reset do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
  end

  desc 'Fills the database with dummy data'
  task :seed do
    puts 'Populating database with dummy data...'
    require './database/seed_dummy_data.rb'
    puts 'Done!'
  end
end
