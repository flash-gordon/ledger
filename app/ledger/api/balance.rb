# skip container registration since
# routes don't need to be in the container
# auto_register: false
require_relative 'base'

module Ledger
  module API
    # Base class contains middlewares
    class Balance < Base
      # Import is defined in app.rb
      include Import[
                'lib.to_cents',             # pure function
                repo: 'repos.account_repo'  # persistance layer
              ]

      get '/' do
        { balance: to_cents.(repo.balance(account.id).balance) }
      end
    end
  end
end
