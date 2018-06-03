require 'ledger/lib/json_response'

RSpec.describe Ledger::Lib::JSONResponse do
  let(:data) { { foo: 'bar', baz: 5 } }

  let(:json) { JSON.dump(data) }

  let(:app) do
    proc { [200, {}, data] }
  end

  subject(:middleware) { described_class.new(app) }

  it 'builds a JSON response' do
    _, headers, response = middleware.({})

    expect(response).to eql([json])
    expect(headers).to include('Content-Type' => 'application/json')
  end
end
