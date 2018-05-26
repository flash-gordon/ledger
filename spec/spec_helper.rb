
require 'bundler/setup'

require 'rspec'

begin
  require 'pry-byebug'
rescue LoadError
end

require 'dotenv'
Dotenv.load('.env.test', '.env')

SPEC_ROOT = Pathname(__FILE__).dirname

Dir[SPEC_ROOT.join('/factories/**/*.rb')].each { |f| require f }
Dir[SPEC_ROOT.join('/support/**/*.rb')].each { |f| require f }

require SPEC_ROOT.join('../system/ledger/app')

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
end
