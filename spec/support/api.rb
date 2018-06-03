require 'rack/test'
require 'base64'
require 'securerandom'
require 'digest'

module APIHelper
  include Rack::Test::Methods

  attr_reader :account, :api_key

  def parse_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def make_auth_headers(key, auth_type = 'Basic')
    key_encoded = Base64.encode64("#{ key }:")
    { 'HTTP_AUTHORIZATION' => "#{ auth_type } #{ key_encoded }" }
  end

  def create_api_key
    @api_key = SecureRandom.uuid
    hashed_key = Digest::SHA256.hexdigest(api_key)
    @account = Factory[:account, api_key: hashed_key]
  end
end
