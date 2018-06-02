require 'dry/monads/result'
require 'ledger/operations/authenticate'

RSpec.describe Ledger::Operations::Authenticate do
  include Dry::Monads::Result::Mixin

  let(:hash_key) { Ledger::App['lib.hash_api_key'] }

  subject(:authenticate) { described_class.new(repo: repo) }

  let(:api_key) { SecureRandom.uuid }

  let(:account) { Factory.structs[:account, api_key: hash_key.(api_key)] }

  context 'successful authentication' do
    let(:repo) { double(find_by_api_key: account) }

    it 'succeeds' do
      expect(authenticate.(api_key)).to eql(Success(account))
    end
  end

  context 'unsuccessful authentication' do
    let(:repo) { double(find_by_api_key: nil) }

    it 'fails' do
      expect(authenticate.('123')).to eql(Failure(:account_not_found))
    end
  end
end
