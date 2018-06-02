module Persistence
  module Relations
    class Payouts < ROM::Relation[:sql]
      schema(:payouts) do
        attribute :id,         Types::Serial
        attribute :account_id, Types::ForeignKey(:accounts)
        attribute :amount,     Types::Decimal

        attribute :created_at, Types::Time
        attribute :updated_at, Types::Time

        associations do
          belongs_to :account
        end
      end
    end
  end
end
