require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one_attached(:avatar).dependent(:destroy) }
    it { is_expected.to have_many(:lots).dependent(:destroy) }
    it { is_expected.to have_many(:bids).dependent(:destroy) }
  end

  describe 'devise modules' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:unconfirmed_email).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:surname).of_type(:string) }
    it { is_expected.to have_db_column(:role).of_type(:integer).with_options(default: 'user') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe '.from_omniauth' do
    let(:access_token) do
      double('access_token', info: {
        'email' => 'test@example.com',
        'name' => 'John Doe'
      })
    end

    context 'when the user with the email exists' do
      let!(:existing_user) { User.create(email: 'test@example.com', password: 'password') }

      it 'returns the existing user' do
        expect(User.from_omniauth(access_token)).to eq(existing_user)
      end
    end

    context 'when the user with the email does not exist' do
      it 'creates a new user' do
        expect {
          User.from_omniauth(access_token)
        }.to change(User, :count).by(1)
      end

      it 'returns the new user' do
        new_user = User.from_omniauth(access_token)
        expect(new_user).to be_a(User)
        expect(new_user.email).to eq('test@example.com')
      end
    end
  end

  describe '#set_default_role' do
    it 'sets the default role to user' do
      user = User.new
      expect(user.role).to eq('user')
    end

    it 'does not change the role if it is already set' do
      user = User.new(role: 'admin')
      expect(user.role).to eq('admin')
    end
  end
end
