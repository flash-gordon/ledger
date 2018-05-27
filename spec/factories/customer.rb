require 'bigdecimal'

Factory.define :customer do |f|
  f.association(:account)
  f.timestamps
end
