require 'bigdecimal'

Factory.define :charge do |f|
  f.amount { Kernel::BigDecimal("#{ rand(100) }.#{ rand(100) }") }
  f.association(:customer)
  f.timestamps
end
