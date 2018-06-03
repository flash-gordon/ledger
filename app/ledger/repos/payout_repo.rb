module Ledger
  module Repos
    class PayoutRepo < ROM::Repository[:payouts]
      include ArgsImport['persistence.rom']

      def list_payouts(account_id)
        payouts.by_account_id(account_id).to_a
      end

      def create(payout)
        payouts.
          changeset(:create, payout).
          map(:add_timestamps).
          commit
      end
    end
  end
end
