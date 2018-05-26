Ledger::App.boot :settings, from: :system do
  before :init do
    ::Kernel.require "types"
  end

  settings do
    key :database_url, Types::Strict::String.constrained(filled: true)
  end
end
