require 'singleton'
require 'digest'

module Ledger
  module Lib
    class HashAPIKey
      include Singleton

      def call(key)
        Digest::SHA256.hexdigest(key)
      end
    end
  end
end
