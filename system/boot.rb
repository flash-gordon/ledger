begin
  require "pry-byebug"
rescue LoadError
end

require_relative 'ledger/app'

Ledger::Container.finalize!

Dir.glob('../app/ledger/api/*.rb').each { |f| require f }
