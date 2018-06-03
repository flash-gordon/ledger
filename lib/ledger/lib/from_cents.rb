require 'bigdecimal'

module Ledger
  module Lib
    class FromCents
      def call(amount)
        BigDecimal(amount) / 100
      end
    end
  end
end
