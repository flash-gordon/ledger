require 'bigdecimal'
require 'faker'

Factory.define :customer do |f|
  f.name { fake(:company, :name) }
  f.association(:account)
  f.timestamps
end
