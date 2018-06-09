require 'ledger/api/customers'

RSpec.describe '/customers', :db, :api do
  let(:app) { Ledger::API::Customers }

  describe 'POST' do
    let(:api_key) { SecureRandom.uuid }
    let!(:account) { Factory[:account, api_key: Digest::SHA256.hexdigest(api_key)] }
    let(:customer) { Factory.structs[:customer, account: account] }

    example 'creating a new customer link to account' do
      body = JSON.dump(
        name: customer.name
      )

      post '/', body, make_auth_headers(api_key)

      expect(parse_response(last_response)).
        to include(name: customer.name)
    end

    example 'invalid request' do
      post '/', JSON.dump({}), make_auth_headers(api_key)

      expect(parse_response(last_response)).
        to include(name: ['is missing'])
    end
  end
end
