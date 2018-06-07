require 'base64'
require 'ledger/lib/basic_auth'
require 'dry/monads/result'

RSpec.describe Ledger::Lib::BasicAuth, :api do
  include Dry::Monads::Result::Mixin

  let(:api_key) { SecureRandom.uuid }

  subject(:auth) { described_class.instance }

  it 'extracts username from auth request' do
    env = make_auth_headers(api_key)
    expect(auth.(env)).to eql(Success(api_key))
  end
end
