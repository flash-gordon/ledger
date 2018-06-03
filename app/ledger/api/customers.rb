# auto_register: false
require_relative 'base'

module Ledger
  module API
    class Customers < Base
      post '/' do
        create_customer.(account, data).fmap { |customer|
          { id: customer.id, name: customer.name }
        }.value_or { FAILED }
      end
    end
  end
end
