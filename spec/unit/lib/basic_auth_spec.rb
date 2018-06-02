require 'base64'
require 'ledger/lib/basic_auth'
require 'dry/monads/result'

RSpec.describe Ledger::Lib::BasicAuth do
  include Dry::Monads::Result::Mixin

  let(:api_key) { SecureRandom.uuid }

  subject(:auth) { described_class.new }

  def make_headers(key, auth_type = 'Basic')
    key_encoded = Base64.encode64("#{ key }:")
    { 'HTTP_AUTHORIZATION' => "#{ auth_type } #{ key_encoded }" }
  end

  it 'extracts username from auth request' do
    expect(auth.(make_headers(api_key))).to eql(Success(api_key))
  end
end
