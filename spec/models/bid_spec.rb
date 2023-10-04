require 'rails_helper'

RSpec.describe Bid, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com') }
  let(:lot) { Lot.create(initial_price: 100) }

  subject(:bid) { described_class.new(amount: 150, user: user, lot: lot) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:lot) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }

    it 'validates the numericality of amount' do
      is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(lot.initial_price)
    end
  end
end
