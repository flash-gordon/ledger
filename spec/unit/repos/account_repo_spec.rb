require 'ledger/repos/account_repo'

RSpec.describe Ledger::Repos::AccountRepo, :db do
  subject(:repo) { described_class.new(rom) }

  let(:account) { Factory[:account] }
  let(:customer) { Factory[:customer, account: account] }

  describe '#balance' do
    let!(:charges) { 3.times.map { Factory[:charge, customer: Factory[:customer, account: account]] } }
    let!(:payouts) { 3.times.map { Factory[:payout, account: account] } }

    it 'adds chargs and subtracts payouts' do
      account_with_balance = repo.balance(account.id)

      expect(account_with_balance.balance).
        to eql(charges.sum(&:amount) - payouts.sum(&:amount))
    end
  end
end
