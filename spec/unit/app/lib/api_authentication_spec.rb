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

  subject(:middleware) { described_class.new(app, authenticate: authenticate) }

  describe 'success' do
    let(:authenticate) do
      proc do |key|
        expect(key).to eql(api_key)
        Success(account)
      end
    end

    it 'searches account by key and adds it to env' do
      env = make_auth_headers(api_key)
      middleware.(env)

      updated_env = requests[0]

      expect(updated_env).to include('ledger.account' => account)
    end
  end

  describe 'failure' do
    let(:authenticate) do
      proc { Failure(:account_not_found) }
    end

    it 'return 401 back' do
      env = make_auth_headers(api_key)
      status, * = middleware.(env)

      expect(status).to eql(401)
      expect(requests).to be_empty
    end
  end
end
