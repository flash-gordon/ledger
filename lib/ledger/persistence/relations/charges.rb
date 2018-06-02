module Persistence
  module Relations
    class Charges < ROM::Relation[:sql]
      schema(:charges) do
        attribute :id,          Types::Serial
        attribute :customer_id, Types::ForeignKey(:customers)
        attribute :amount,      Types::Decimal

        attribute :created_at,  Types::Time
        attribute :updated_at,  Types::Time

        associations do
          belongs_to :customer
        end
      end
    end
  end
end
