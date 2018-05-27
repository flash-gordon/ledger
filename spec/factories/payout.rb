require 'bigdecimal'

Factory.define :payout do |f|
  f.amount { Kernel::BigDecimal("#{ rand(100) }.#{ rand(100) }") }
  f.association(:account)
  f.timestamps
end
