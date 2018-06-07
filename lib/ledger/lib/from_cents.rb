require 'singleton'
require 'bigdecimal'

module Ledger
  module Lib
    class FromCents
      include Singleton

      def call(amount)
        BigDecimal(amount) / 100
      end
    end
  end
end
