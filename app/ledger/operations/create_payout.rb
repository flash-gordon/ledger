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
          option :account

          config.type_specs = true
          config.messages_file = Ledger::App.root.join('config/errors.yml')

          def has_funds?(amount)
            account.balance * 100 >= amount
          end
        end

        required(:amount, :integer).filled(:int?, :has_funds?)
      end

      include Import['lib.from_cents']

      attr_reader :account_repo

      attr_reader :payout_repo

      def initialize(account_repo:, payout_repo:, **deps)
        super(deps)
        @account_repo = account_repo
        @payout_repo = payout_repo
      end

      def call(account, params)
        account_repo.lock(account.id) do |account_with_balance|
          schema = Schema.with(account: account_with_balance)

          values = yield schema.(params)

          amount = from_cents.(values[:amount])

          payout = payout_repo.create(account_id: account.id, amount: amount)

          Success(payout)
        end
      end
    end
  end
end
