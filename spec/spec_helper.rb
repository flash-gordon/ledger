ENV['APP_ENV'] = 'test'
require 'bundler/setup'

require 'rspec'

begin
  require 'pry-byebug'
rescue LoadError
end

require 'dotenv'
Dotenv.load('.env.test', '.env')

require 'warning'
Warning.ignore(/sequel/)
Warning.ignore(/dry-system/)

SPEC_ROOT = Pathname(__FILE__).dirname

require SPEC_ROOT.join('../system/ledger/app')

Dir[SPEC_ROOT.join('support/**/*.rb')].each { |f| require f }
Dir[SPEC_ROOT.join('factories/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true

  config.include DbHelper, :db
  config.include APIHelper, :api

  config.around :each, :db do |ex|
    Ledger::App['persistence.rom'].gateways[:default].transaction(rollback: :always, &ex)
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end

  config.before :all, :db do
    Ledger::App.start(:persistence)
  end

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
end
