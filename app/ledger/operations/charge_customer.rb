require 'dry/monads/do/all'
require 'dry/monads/result'
require 'dry/validation'

module Ledger
  module Operations
    class ChargeCustomer
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do::All

      attr_reader :repo

      def initialize(repo:)
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

        Success(repo.create(values))
      end
    end
  end
end
