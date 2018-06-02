require 'dry/monads/result'

module Ledger
  module Lib
    class BasicAuth
      HTTP_BASIC = 'HTTP_AUTHORIZATION'

      include Dry::Monads::Result::Mixin

      def call(env)
        header = env[HTTP_BASIC]
        return Failure(:no_header) if header.nil?

        scheme, parts = header.split(' ', 2)
        return Failure(:unsupported_scheme) unless scheme.downcase == 'basic'

        key, _ = parts.unpack('m*')[0].split(':', 2)
        Success(key)
      end
    end
  end
end
