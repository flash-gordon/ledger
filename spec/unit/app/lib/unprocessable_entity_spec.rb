require 'ledger/lib/unprocessable_entity'

RSpec.describe Ledger::Lib::UnprocessableEntity do
  subject(:response) { described_class.new }

  it 'adds status code' do
    obj = Object.new
    expect(response.(obj)).to eql([422, obj])
  end
end
