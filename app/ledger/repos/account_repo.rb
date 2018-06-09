require 'rom/repository'

module Ledger
  module Repos
    class AccountRepo < ROM::Repository[:accounts]
      # sequential injection
      include ArgsImport['persistence.rom']

      # RO balance access
      # shall not be used for writing data outside of
      # transactions
      def balance(account_id)
        balances.by_pk(account_id).one!
      end

      # pessimistic account lock
      def lock(account_id)
        transaction do
          account = balances.lock.by_pk(account_id).one!
          yield(account)
        end
      end

      def find_by_api_key(key)
        accounts.by_api_key(key).one
      end

      private

      def balances
        accounts.with_balance
      end
    end
  end
end
