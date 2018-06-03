# auto_register: false
require 'sinatra/base'
require 'ledger/lib/api_authentication'
require 'ledger/lib/json_body'
require 'ledger/lib/json_response'

module Ledger
  module API
    class Base < Sinatra::Application
      use Lib::APIAuthentication
      use Lib::JSONBody
      use Lib::JSONResponse

      include Import['operations.create_customer']

      FAILED = 'No luck'

      def account
        env.fetch(Lib::APIAuthentication::ACCOUNT_KEY)
      end

      def data
        env.fetch(Lib::JSONBody::JSON_KEY)
      end
    end
  end
end
