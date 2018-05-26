require 'rom-factory'

Factory = ROM::Factory.configure do |config|
  config.rom = Ledger::App['persistence.rom']
end
