require 'ledger/api/balance'

RSpec.describe '/balance', :db, :api do
  let(:app) { Ledger::API::Balance }

  context 'for new account' do
    before { create_api_key }

    it 'returns 0' do
      get '/', nil, make_auth_headers(api_key)

      expect(parse_response(last_response)).
        to eql(balance: 0.0)
    end
  end
end
