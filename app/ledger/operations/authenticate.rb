require 'dry/monads/result'

module Ledger
  module Operations
    class Authenticate
      # adds Success(...) and Failure(...)
      include Dry::Monads::Result::Mixin

      include Import[
                'lib.hash_api_key',
                repo: 'repos.account_repo'
              ]

      def call(key)
        hashed_key = hash_api_key.(key)

        account = repo.find_by_api_key(hashed_key)

        if account
          Success(account)
        else
          Failure(:account_not_found)
        end
      end
    end
  end
end
