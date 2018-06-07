require 'ledger/operations/create_payout'

RSpec.describe Ledger::Operations::CreatePayout do
  include Dry::Monads::Result::Mixin

  let(:account) { Factory.structs[:account] }

  let(:payout) { Factory.structs[:charge, account: account] }

  let(:balance) { double(balance: payout.amount) }

  let(:account_repo) do
    repo = double('account repo')
    allow(repo).to receive(:lock).and_yield(balance)
    repo
  end

  subject(:operation) do
    described_class.new(
      account_repo: account_repo,
      payout_repo: payout_repo
    )
  end

  context 'successful payout' do
    let(:payout_repo) do
      repo = double('payout repo')
      allow(repo).to receive(:create).
                       with(
                         account_id: account.id,
                         amount: payout.amount
                       ).
                       and_return(payout)
      repo
    end

    it 'creates a new payout' do
      params = {
        'amount' => Integer(payout.amount * 100)
      }

      expect(operation.(account, params)).to eql(Success(payout))
    end
  end

  context 'low balance' do
    let(:payout_repo) { double('payout repo') }

    let(:balance) { double(balance: 0.to_d) }

    it 'declines a payout' do
      params = {
        'amount' => 1
      }

      expect(operation.(account, params)).
        to eql(Failure(amount: ["insufficient funds"]))
    end
  end
end
