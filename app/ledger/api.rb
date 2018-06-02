require 'sinatra/base'
require 'ledger/lib/api_authentication'

module Ledger
  class API < Sinatra::Application
    use Ledger::Lib::APIAuthentication

    include Import['operations.create_customer']

    FAILED = 'No luck'

    post '/customers' do
      data = JSON.parse(request.body.read, symbolize_names: true)
      create_customer.(account, data).fmap { |customer|
        JSON.dump(
          id: customer.id,
          name: customer.name
        )
      }.value_or { FAILED }
    end

    def account
      env.fetch(Lib::APIAuthentication::ACCOUNT_KEY)
    end
  end
end
