# auto_register: false
require_relative 'base'

module Ledger
  module API
    class Customers < Base
      include Import['operations.create_customer']

      post '/' do
        create_customer.(account, data).
          fmap { |customer| { id: customer.id, name: customer.name } }.
          value_or { |errors| unprocessable_entity.(errors) }
      end
    end
  end
end
