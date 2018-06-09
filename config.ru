require_relative 'system/boot'
map('/balance') { run Ledger::API::Balance }
map('/customers') { run Ledger::API::Customers }
map('/payouts') { run Ledger::API::Payouts }
