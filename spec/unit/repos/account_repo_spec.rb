require 'ledger/repos/account_repo'

RSpec.describe Ledger::Repos::AccountRepo, :db do
  subject(:repo) { described_class.new(rom) }

  let(:account) { Factory[:account] }

  let(:customer) { Factory[:customer, account: account] }

  def create_charge
    Factory[:charge, customer: Factory[:customer, account: account]]
  end

  def create_payout
    Factory[:payout, account: account]
  end

  describe '#balance' do
    let!(:charges) { 3.times.map { create_charge } }
    let!(:payouts) { 3.times.map { create_payout } }

    it 'adds chargs and subtracts payouts' do
      account_with_balance = repo.balance(account.id)

      expect(account_with_balance.balance).
        to eql(charges.sum(&:amount) - payouts.sum(&:amount))
    end
  end

  describe 'lock' do
    let!(:charge) { create_charge }

    it 'yields a block and passes balance' do
      account_with_balance = nil
      repo.lock(account.id) { |account| account_with_balance = account }

      expect(account_with_balance.balance).to eql(charge.amount)
    end
  end
end
