require 'ledger/lib/generate_api_key'

RSpec.describe Ledger::Lib::GenerateAPIKey do
  subject(:generate) { described_class.new }

  it 'creates a random key' do
    expect(generate.call).not_to eql(generate.call)
  end
end
