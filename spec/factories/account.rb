require 'securerandom'
require 'digest'

Factory.define :account do |f|
  f.currency 'usd'
  f.api_key { Digest::SHA256.hexdigest(SecureRandom.uuid) }
  f.timestamps
end
