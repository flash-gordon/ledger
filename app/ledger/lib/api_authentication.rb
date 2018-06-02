# auto_register: false

module Ledger
  module Lib
    class APIAuthentication
      UNAUTHORIZED = [401, {}, ['Unauthorized']]

      include Import[
                'operations.authenticate',
                'lib.basic_auth'
              ]

      def initialize(app, deps)
        super(deps)
        @app = app
      end

      def call(env)
        basic_auth.(env).
          bind(authenticate).
          fmap { |account| @app.(env.merge(account: account)) }.
          value_or(UNAUTHORIZED)
      end

      def api_key(env)
        env[HTTP_BASIC]
      end
    end
  end
end
