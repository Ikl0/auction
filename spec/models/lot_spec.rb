require 'rails_helper'

RSpec.describe Lot, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com') }

  subject(:lot) { described_class.new(name: 'Example Lot', description: 'Lorem ipsum', user: user) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:winner).class_name('User').optional }
    it { is_expected.to have_many(:bids).dependent(:destroy) }
    it { is_expected.to have_many_attached(:images).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#tags=' do
    it 'splits a comma-separated string into an array of tags' do
      lot.tags = 'tag1, tag2, tag3'
      expect(lot.tags).to eq(['tag1', 'tag2', 'tag3'])
    end

    it 'does not modify an already existing array of tags' do
      lot.tags = ['tag1', 'tag2']
      lot.tags = 'tag3, tag4'
      expect(lot.tags).to eq(['tag1', 'tag2', 'tag3', 'tag4'])
    end
  end

  describe '.find_by' do
    it 'returns lots matching the given tags' do
      lot1 = Lot.create(name: 'Lot 1', description: 'Description 1', user: user, tags: ['tag1', 'tag2'])
      lot2 = Lot.create(name: 'Lot 2', description: 'Description 2', user: user, tags: ['tag2', 'tag3'])

      expect(Lot.find_by(tags: ['tag1'])).to contain_exactly(lot1)
      expect(Lot.find_by(tags: ['tag2'])).to contain_exactly(lot1, lot2)
      expect(Lot.find_by(tags: ['tag3'])).to contain_exactly(lot2)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns searchable attributes' do
      expect(described_class.ransackable_attributes).to eq(['name'])
    end
  end

  describe '#owned_by?' do
    it 'returns true if the lot is owned by the given user' do
      expect(lot.owned_by?(user)).to be_truthy
    end

    it 'returns false if the lot is not owned by the given user' do
      other_user = User.create(name: 'Jane Smith', email: 'jane@example.com')
      expect(lot.owned_by?(other_user)).to be_falsy
    end
  end
end
