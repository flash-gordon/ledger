require 'securerandom'

module Ledger
  module Lib
    class GenerateAPIKey
      def call
        SecureRandom.uuid
      end
    end
  end
end
