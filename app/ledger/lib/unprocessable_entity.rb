module Ledger
  module Lib
    class UnprocessableEntity
      def call(errors)
        [422, errors]
      end
    end
  end
end
