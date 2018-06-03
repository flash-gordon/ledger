# auto_register: false
require_relative 'base'

module Ledger
  module API
    class Balance < Base
      include Import[
                'lib.to_cents',
                repo: 'repos.account_repo'
              ]

      get '/' do
        { balance: to_cents.(repo.balance(account.id).balance) }
      end
    end
  end
end
