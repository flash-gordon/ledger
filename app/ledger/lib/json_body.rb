# auto_register: false
require 'json'
require 'dry/monads/try'

module Ledger
  module Lib
    class JSONBody
      IO_KEY = 'rack.input'
      JSON_KEY = 'rack.request.json'
      REQUEST_METHOD = 'REQUEST_METHOD'

      bad_request = 'Bad request'
      BAD_REQUEST = [
        400,
        { 'Content-Type' => 'text/plain', 'Content-Length' => bad_request.size.to_s },
        [bad_request.size]
      ]

      include Dry::Monads::Try::Mixin

      def initialize(app)
        @app = app
      end

      def call(env)
        if get?(env)
          @app.(env)
        else
          body = env[IO_KEY].read
          Try[JSON::ParserError] { JSON.parse(body, symbolize_names: true) }.
            fmap { |json| @app.(env.merge(JSON_KEY => json)) }.
            value_or(BAD_REQUEST)
        end
      end

      def get?(env)
        env[REQUEST_METHOD] == 'GET'
      end
    end
  end
end
