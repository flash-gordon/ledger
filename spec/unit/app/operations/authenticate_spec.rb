require 'dry/monads/result'
require 'ledger/operations/authenticate'

# covers happy and unhappy paths for authentication
RSpec.describe Ledger::Operations::Authenticate do
  include Dry::Monads::Result::Mixin

  # operation with injected dependency
  subject(:authenticate) { described_class.new(repo: repo) }

  let(:hash_key) { Ledger::App['lib.hash_api_key'] }

  let(:api_key) { SecureRandom.uuid }

  # Factory.structs don't create DB records
  let(:account) { Factory.structs[:account, api_key: hash_key.(api_key)] }

  context 'account exists' do
    # access to persistence layer
    let(:repo) { double(find_by_api_key: account) }

    it 'succeeds' do
      expect(authenticate.(api_key)).to eql(Success(account))
    end
  end

  context 'no account' do
    let(:repo) { double(find_by_api_key: nil) }

    it 'fails' do
      expect(authenticate.('123')).to eql(Failure(:account_not_found))
    end
  end
end
