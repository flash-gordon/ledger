require 'singleton'

module Ledger
  module Lib
    class ToCents
      # FYI singletons are supported but don't
      # give advantage
      include Singleton

      def call(amount)
        Integer(amount * 100)
      end
    end
  end
end
