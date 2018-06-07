require 'bigdecimal'
require 'ledger/lib/to_cents'
require 'ledger/lib/from_cents'

RSpec.describe 'ToCents/FromCents' do
  def random_integer
    rand(100_000) - 50_000
  end

  def random_decimal
    BigDecimal(random_integer) / 100
  end

  let(:to_cents) { Ledger::Lib::ToCents.instance }

  let(:from_cents) { Ledger::Lib::FromCents.instance }

  context 'to cents' do
    it 'converts decimal to cents' do
      expect(to_cents.(BigDecimal('123.45'))).to eql(12345)
    end
  end

  context 'from cents' do
    it 'converts cents to decimal' do
      expect(from_cents.(12345)).to eql(BigDecimal('123.45'))
    end
  end

  specify 'operations are isomorphic' do
    100.times do
      cents = random_integer
      expect(to_cents.(from_cents.(cents))).to eql(cents)
    end

    100.times do
      decimal = random_decimal
      expect(from_cents.(to_cents.(decimal))).to eql(decimal)
    end
  end
end
