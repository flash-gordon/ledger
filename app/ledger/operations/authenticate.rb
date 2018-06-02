require 'dry/monads/result'

module Ledger
  module Operations
    class Authenticate
      include Dry::Monads::Result::Mixin
      include Import['lib.hash_api_key']

      attr_reader :repo

      def initialize(repo:, **kwargs)
        super(kwargs)
        @repo = repo
      end

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
