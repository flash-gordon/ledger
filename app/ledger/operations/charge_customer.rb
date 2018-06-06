require 'dry/monads/do'
require 'dry/monads/result'
require 'dry/validation'

module Ledger
  module Operations
    class ChargeCustomer
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do

      include Import['lib.from_cents']

      attr_reader :repo

      def initialize(repo:, **deps)
        super(deps)
        @repo = repo
      end

      Schema = Dry::Validation.JSON do
        configure do
          option :account
          option :repo

          config.type_specs = true

          def customer_exist?(customer)
            repo.customer_exist?(account.id, customer)
          end
        end

        required(:amount, :integer).filled(:int?, gt?: 0)
        required(:customer, :integer).filled(:int?, :customer_exist?)
      end

      def call(account, params)
        schema = Schema.with(account: account, repo: repo)

        values = yield schema.(params)

        amount = from_cents.(values[:amount])

        Success(repo.create(amount: amount, customer_id: values[:customer]))
      end
    end
  end
end
