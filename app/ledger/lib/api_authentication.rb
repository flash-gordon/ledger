# auto_register: false

module Ledger
  module Lib
    class APIAuthentication
      UNAUTHORIZED = [401, {}, ['Unauthorized']]
      ACCOUNT_KEY = 'ledger.account'

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
          fmap { |account| @app.(env.merge(ACCOUNT_KEY => account)) }.
          value_or(UNAUTHORIZED)
      end
    end
  end
end
