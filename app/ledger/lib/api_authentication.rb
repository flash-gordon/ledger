# frozen_string_literal: true
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

      # dry-auto_inject is compatible with existing constructor
      def initialize(app, deps)
        # we pass dependencies and assign them in `super`
        super(deps)
        @app = app
      end

      def call(env)
        # get API key from request
        basic_auth.(env).
          # try to authenticate
          bind(authenticate).
          # either this line works
          fmap { |account| @app.(env.merge(ACCOUNT_KEY => account)) }.
          # or this one
          value_or(UNAUTHORIZED)
      end
    end
  end
end
