require 'ledger/lib/json_body'

RSpec.describe Ledger::Lib::JSONBody do
  let(:data) { { foo: 'bar', baz: 5 } }

  let(:json) { JSON.dump(data) }

  let(:requests) { [] }

  let(:env) do
    {
      'rack.input' => double(read: json),
      'REQUEST_METHOD' => 'POST'
    }
  end

  let(:app) do
    proc do |env|
      requests << env
      [200, {}, ["OK"]]
    end
  end

  subject(:middleware) { described_class.new(app) }

  it 'parses json request' do
    middleware.(env)

    updated_env = requests[0]

    expect(updated_env).to include('rack.request.json' => data)
  end

  context 'GET' do
    it 'passes through GET requests' do
      middleware.('REQUEST_METHOD' => 'GET')

      updated_env = requests[0]

      expect(updated_env).not_to have_key('rack.request.json')
    end
  end
end
