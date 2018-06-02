require 'rack/test'

module APIHelper
  include Rack::Test::Methods

  def app
    Ledger::API
  end

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def make_auth_headers(key, auth_type = 'Basic')
    key_encoded = Base64.encode64("#{ key }:")
    { 'HTTP_AUTHORIZATION' => "#{ auth_type } #{ key_encoded }" }
  end
end
