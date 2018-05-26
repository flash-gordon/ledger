module Persistence
  module Relations
    class Charges < ROM::Relation[:sql]
      schema(:charges) do
        attribute :id,          Types::Serial
        attribute :customer_id, Types::ForeignKey(:customers)
        attribute :account_id,  Types::ForeignKey(:accounts)
        attribute :amount,      Types::Decimal
        attribute :currency,    Types::String

        attribute :created_at,  Types::Time
        attribute :updated_at,  Types::Time

        associations do
          belongs_to :account
          belongs_to :customer
        end
      end
    end
  end
end
