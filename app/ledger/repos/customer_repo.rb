module Ledger
  module Repos
    class CustomerRepo < ROM::Repository[:customers]
      include ArgsImport['persistence.rom']

      commands :create
    end
  end
end
