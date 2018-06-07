require 'dry/monads/result'
require 'ledger/operations/create_customer'

RSpec.describe Ledger::Operations::CreateCustomer do
  include Dry::Monads::Result::Mixin

  let(:account) { Factory.structs[:account] }
  let(:customer) { Factory.structs[:customer, account: account] }

  subject(:operation) { described_class.new(repo: double(create: customer)) }

  it 'creates a customer' do
    params = {
      'name' => customer.name
    }

    expect(operation.(account, params)).to eql(Success(customer))
  end
end
