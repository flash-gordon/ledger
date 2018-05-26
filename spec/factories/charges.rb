require 'bigdecimal'

Factory.define :charges do |f|
  f.sequence(:id)
  f.amount { BigDecimal("#{ rand(100) }.#{ rand(100) }") }
  f.currency 'usd'
  f.association(:customer)
  f.timestamps
end
