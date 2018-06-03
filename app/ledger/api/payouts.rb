# auto_register: false
require_relative 'base'

module Ledger
  module API
    class Payouts < Base
      include Import['operations.create_payout']

      post '/' do
        create_payout.(account, data).
          fmap { |payout| { id: payout.id } }.
          value_or { |errors| errors }
      end
    end
  end
end
