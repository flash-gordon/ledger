require 'dry/monads/result'
require 'ledger/lib/api_authentication'

RSpec.describe Ledger::Lib::APIAuthentication, :api do
  include Dry::Monads::Result::Mixin

  let(:api_key) { SecureRandom.uuid }

  let(:requests) { [] }

  let(:app) do
    proc do |env|
      requests << env
      [200, {}, ["OK"]]
    end
  end

  let(:account) { Factory.structs[:account] }
  let(:authenticate) do
    proc do |key|
      expect(key).to eql(api_key)
      Success(account)
    end
  end

  subject(:middleware) { described_class.new(app, authenticate: authenticate) }

  it 'searches account by key and adds it to env' do
    env = make_auth_headers(api_key)
    middleware.(env)

    updated_env = requests[0]

    expect(updated_env).to include('ledger.account' => account)
  end
end
