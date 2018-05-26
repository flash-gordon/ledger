module Persistence
  module Relations
    class Accounts < ROM::Relation[:sql]
      schema(:accounts) do
        attribute :id,         Types::Serial

        attribute :created_at, Types::Time
        attribute :updated_at, Types::Time
      end
    end
  end
end
