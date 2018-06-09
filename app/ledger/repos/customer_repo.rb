require 'rom/repository'

module Ledger
  module Repos
    class CustomerRepo < ROM::Repository[:customers]
      include ArgsImport['persistence.rom']

      def create(customer)
        customers.
          changeset(:create, customer).
          map(:add_timestamps).
          commit
      end
    end
  end
end
