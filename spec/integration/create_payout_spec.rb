require 'ledger/api/payouts'

RSpec.describe '/payouts', :db, :api do
  before { create_api_key }

  let(:app) { Ledger::API::Payouts }

  let(:payout_repo) { Ledger::App['repos.payout_repo'] }

  describe 'POST' do
    let(:payout) { Factory.structs[:payout, account: account] }

    before do
      customer = Factory[:customer, account: account]
      Factory[:charge, customer: customer, amount: payout.amount]
    end

    example 'creating a payout' do
      body = JSON.dump(
        amount: Integer(payout.amount * 100)
      )

      post '/', body, make_auth_headers(api_key)

      account_payouts = payout_repo.list_payouts(account.id)

      expect(account_payouts.size).to eql(1)

      persisted_payout = account_payouts[0]

      expect(persisted_payout.amount).to eql(payout.amount)
      expect(persisted_payout.account_id).to eql(account.id)

      expect(parse_response(last_response)).
        to eql(id: persisted_payout.id)
    end
  end
end
