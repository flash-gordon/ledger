require 'dry/monads/result'
require 'operations/authenticate'

RSpec.describe Ledger::Operations::Authenticate do
  include Dry::Monads::Result::Mixin

  let(:hash_key) { Ledger::App['lib.hash_api_key'] }

  let(:subject) { described_class.new(repo: repo) }

  context 'successful authentication' do
    let(:api_key) { SecureRandom.uuid }

    let(:account) { Factory.structs[:account, api_key: hash_key.(api_key)] }

    let(:repo) { double(find_by_api_key: account) }

    it 'succeeds' do
      expect(subject.(api_key)).to eql(Success(account))
    end
  end
end
