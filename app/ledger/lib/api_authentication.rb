# frozen_string_literal: true
# auto_register: false

module Ledger
  module Lib
    class APIAuthentication
      UNAUTHORIZED = [401, {}, ['Unauthorized']]
      ACCOUNT_KEY = 'ledger.account'

      # add dependencies from container
      include Import[
                # actual authentication logic
                # resides in operations/authenticate.rb
                'operations.authenticate',
                # get API key by request
                'lib.basic_auth'
              ]

      # dry-auto_inject is compatible with existing constructor
      # and even works with inheritance
      def initialize(app, deps)
        # we pass dependencies and assign them in `super`
        super(deps)
        @app = app
      end

      def call(env)
        # get API key from request
        # .() is shortcut for .call()
        basic_auth.(env).
          # try to authenticate
          bind(authenticate).
          # either this line works
          fmap { |account| @app.(env.merge(ACCOUNT_KEY => account)) }.
          # or this one
          value_or(UNAUTHORIZED)
      end

      # # Alternative #call implementation
      # def call(env)
      #   api_key = basic_auth.call(env)
      #   account = authenticate.call(api_key) if api_key
      #
      #   if account
      #     @app.(env.merge(ACCOUNT_KEY => account))
      #   else
      #     UNAUTHORIZED
      #   end
      # end
    end
  end
end
