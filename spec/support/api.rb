require 'rack/test'
require 'base64'

module APIHelper
  include Rack::Test::Methods

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def make_auth_headers(key, auth_type = 'Basic')
    key_encoded = Base64.encode64("#{ key }:")
    { 'HTTP_AUTHORIZATION' => "#{ auth_type } #{ key_encoded }" }
  end
end
