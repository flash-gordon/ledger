require 'dry/validation'
require 'dry/monads/result'
require 'dry/monads/do/all'

Dry::Validation.load_extensions(:monads)

module Ledger
  module Operations
    class CreateCustomer
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Do::All

      Schema = Dry::Validation.JSON do
        configure do
          config.type_specs = true
        end

        required(:name, :string).filled(:str?)
      end

      include Import[repo: 'repos.customer_repo']

      def call(account, params)
        values = yield Schema.(params)

        customer = repo.create(account_id: account.id, **values)

        Success(customer)
      end
    end
  end
end
