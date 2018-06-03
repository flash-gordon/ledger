module Ledger
  module Lib
    class ToCents
      def call(amount)
        Integer(amount * 100)
      end
    end
  end
end
