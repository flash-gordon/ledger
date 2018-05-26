require 'bigdecimal'

Factory.define :payouts do |f|
  f.sequence(:id)
  f.amount { BigDecimal("#{ rand(100) }.#{ rand(100) }") }
  f.currency 'usd'
  f.association(:account)
  f.timestamps
end
