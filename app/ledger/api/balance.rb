# auto_register: false
require_relative 'base'

module Ledger
  module API
    class Balance < Base
      include Import[repo: 'repos.account_repo']

      get '/' do
        { balance: repo.balance(account.id).balance.to_f }
      end
    end
  end
end
