require 'dry/monads/result'
require 'ledger/operations/charge_customer'

RSpec.describe Ledger::Operations::ChargeCustomer do
  include Dry::Monads::Result::Mixin

  let(:account) { Factory.structs[:account] }
  let(:customer) { Factory.structs[:customer, account: account] }
  let(:charge) { Factory.structs[:charge, customer: customer] }

  subject(:operation) do
    described_class.new(
      repo: double(create: charge, customer_exist?: true)
    )
  end

  it 'creates a charge' do
    params = {
      'amount' => (charge.amount * 100).to_i,
      'customer' => customer.id
    }

    expect(operation.(account, params)).to eql(Success(charge))
  end
end
