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
          option :balance

          config.type_specs = true
          config.messages_file = Ledger::App.root.join('config/errors.yml')

          def has_funds?(amount)
            balance >= amount
          end
        end

        required(:amount, :integer).filled(:int?, :has_funds?)
      end

      include Import[
                'repos.account_repo',
                'repos.payout_repo',
                'lib.from_cents',
                'lib.to_cents'
              ]

      def call(account, params)
        account_repo.lock(account.id) do |account_with_balance|
          schema = Schema.with(balance: to_cents.(account_with_balance.balance))

          values = yield schema.(params)

          amount = from_cents.(values[:amount])

          payout = payout_repo.create(account_id: account.id, amount: amount)

          Success(payout)
        end
      end
    end
  end
end
