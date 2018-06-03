require 'ledger/operations/create_payout'

RSpec.describe Ledger::Operations::CreatePayout do
  include Dry::Monads::Result::Mixin

  subject(:operation) do
    described_class.new(
      repo: double(create: payout)
    )
  end

  let(:account) { Factory.structs[:account] }

  let(:payout) { Factory.structs[:charge, account: account] }

  it 'creates a new payout' do
    params = {
      'amount' => (payout.amount * 100).to_i
    }

    expect(operation.(account, params)).to eql(Success(payout))
  end
end
