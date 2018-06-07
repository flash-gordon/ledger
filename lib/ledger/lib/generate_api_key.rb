require 'singleton'
require 'securerandom'

module Ledger
  module Lib
    class GenerateAPIKey
      include Singleton

      def call
        SecureRandom.uuid
      end
    end
  end
end
