require 'bigdecimal'

Factory.define :customers do |f|
  f.sequence(:id)
  f.association(:account)
  f.timestamps
end
