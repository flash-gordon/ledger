require 'rom/constants'
require 'rom/repository'

module Ledger
  module Repos
    class AccountRepo < ROM::Repository[:accounts]
      include ArgsImport['persistence.rom']

      def balance(account_id)
        accounts.with_balance.by_pk(account_id).one!
      end

      def find_by_api_key(key)
        accounts.by_api_key(key).one
      end
    end
  end
end
