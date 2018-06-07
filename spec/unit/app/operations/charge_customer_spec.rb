require 'dry/monads/result'
require 'ledger/operations/charge_customer'

RSpec.describe Ledger::Operations::ChargeCustomer do
  include Dry::Monads::Result::Mixin

  let(:account) { Factory.structs[:account] }

  let(:customer) { Factory.structs[:customer, account: account] }

  let(:charge) { Factory.structs[:charge, customer: customer] }

  let(:repo) do
    repo = double('charge repo')

    allow(repo).to receive(:create).
                     with(amount: charge.amount, customer_id: customer.id).
                     and_return(charge)

    allow(repo).to receive(:customer_exist?).
                     with(account.id, customer.id).
                     and_return(true)

    repo
  end

  subject(:operation) do
    described_class.new(repo: repo)
  end

  it 'creates a charge' do
    params = {
      'amount' => Integer(charge.amount * 100),
      'customer' => customer.id
    }

    expect(operation.(account, params)).to eql(Success(charge))
  end
end
