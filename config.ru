require_relative 'system/boot'
map('/customers') { run Ledger::API::Customers }
map('/balance') { run Ledger::API::Balance }
map('/payouts') { run Ledger::API::Payouts }
