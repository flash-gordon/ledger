require 'digest'

module Ledger
  module Lib
    class HashAPIKey
      def call(key)
        Digest::SHA256.hexdigest(key)
      end
    end
  end
end
