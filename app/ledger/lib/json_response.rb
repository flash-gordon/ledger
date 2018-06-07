# frozen_string_literal: true
# auto_register: false
require 'json'

module Ledger
  module Lib
    class JSONResponse
      JSON_HEADERS = { 'Content-Type' => 'application/json' }

      def initialize(app)
        @app = app
      end

      def call(env)
        code, headers, body = @app.(env)

        [code, headers.merge(JSON_HEADERS), [serialize(body)]]
      end

      def serialize(part)
        JSON.dump(part)
      end
    end
  end
end
