require 'securerandom'
require 'ledger/lib/hash_api_key'
require 'digest'

RSpec.describe Ledger::Lib::HashAPIKey do
  subject(:hash_key) { described_class.instance }
  let(:key) { SecureRandom.uuid }

  it 'creates a random key' do
    expect(hash_key.(key)).to eql(Digest::SHA256.hexdigest(key))
  end
end
