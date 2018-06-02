module Persistence
  module Relations
    class Customers < ROM::Relation[:sql]
      schema(:customers) do
        attribute :id,         Types::Serial
        attribute :name,       Types::String
        attribute :account_id, Types::ForeignKey(:accounts)

        attribute :created_at, Types::Time
        attribute :updated_at, Types::Time

        associations do
          belongs_to :account
        end
      end
    end
  end
end
