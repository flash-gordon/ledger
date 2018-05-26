require 'bundler/setup'
require 'pry-byebug' unless ENV['APP_ENV'] == 'production'
require_relative 'system/ledger/app'

namespace :db do
  task :setup do
    Ledger::App.init(:persistence)
  end

  desc 'Modify current database state according to schema definitions'
  task auto_migrate: :setup do
    config = Ledger::App['persistence.config']

    gw = config.gateways[:default]
    gw.auto_migrate!(config, inline: true)
  end
end
