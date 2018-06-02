begin
  require "pry-byebug"
rescue LoadError
end

require_relative 'ledger/app'

Ledger::Container.finalize!

require "api"
