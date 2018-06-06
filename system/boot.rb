begin
  require "pry-byebug"
rescue LoadError
end

require_relative 'ledger/app'

root = Ledger::App.root

Dir.glob(root.join('system/boot/*.rb')).each { |f| require f }
Dir.glob(root.join('app/ledger/api/*.rb')).each { |f| require f }

Ledger::App.finalize!
