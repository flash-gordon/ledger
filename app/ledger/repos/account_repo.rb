require 'rom/constants'
require 'rom/repository'

module Ledger
  module Repos
    class AccountRepo < ROM::Repository[:accounts]
      def balance(account_id)
        accounts.with_balance.by_pk(account_id).one!
      end
    end
  end
end
