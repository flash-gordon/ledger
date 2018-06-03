require 'dry/monads/do/all'
require 'dry/monads/result'
require 'dry/validation'

module Ledger
  module Operations
    class CreatePayout
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do::All

      Schema = Dry::Validation.JSON do
        configure do
          config.type_specs = true
        end
      end

      attr_reader :repo

      def initialize(repo:)
        @repo = repo
      end

      def call(account, params)
        values = yield Schema.(params)

        payout = repo.create(**values, account_id: account.id)

        Success(payout)
      end
    end
  end
end
