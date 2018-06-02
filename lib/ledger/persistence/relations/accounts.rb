module Persistence
  module Relations
    class Accounts < ROM::Relation[:sql]
      schema(:accounts) do
        attribute :id,         Types::Serial
        attribute :currency,   Types::String
        attribute :api_key,    Types::String

        attribute :created_at, Types::Time
        attribute :updated_at, Types::Time

        associations do
          has_many :payouts
          has_many :customers
        end
      end

      def with_balance
        payouts_total = total_amount(payouts).
                          where(payouts[:account_id] => self[:id]).
                          query

        charges_total = total_amount(charges.join(customers)).
                          where(customers[:account_id] => self[:id]).
                          query

        balance = charges_total - payouts_total

        project {
          [
            id,
            charges_total.as(:charges),
            payouts_total.as(:payouts),
            balance.as(:balance)
          ]
        }
      end

      private

      def total_amount(rel)
        rel.project { int::coalesce(int::sum(amount), 0) }
      end
    end
  end
end
