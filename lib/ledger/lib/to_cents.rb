require 'singleton'

module Ledger
  module Lib
    class ToCents
      include Singleton

      def call(amount)
        Integer(amount * 100)
      end
    end
  end
end
