require 'ledger/lib/json_body'

RSpec.describe Ledger::Lib::JSONBody do
  let(:data) { { foo: 'bar', baz: 5 } }

  let(:json) { JSON.dump(data) }

  let(:requests) { [] }

  let(:env) { { 'rack.input' => double(read: json) } }

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
end
