require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validations' do
    subject { create :user }
    it { should have_many(:books).dependent(:destroy) }
    it { should allow_value('0123456789').for(:phone) }
    it { should_not allow_value('A012345678').for(:phone) }
    it { should_not allow_value('a012345678').for(:phone) }
    it { should_not allow_value('#012345678').for(:phone) }
    it { should_not allow_value('@012345678').for(:phone) }
    it { should_not allow_value('0a23456789').for(:phone) }
    it { should_not allow_value('_').for(:phone) }
    it { should validate_uniqueness_of(:phone).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
  end

  context 'length of password' do
    it { should validate_length_of(:phone).is_equal_to(10) }
  end

  context 'maximum length' do
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_length_of(:address).is_at_most(50) }
  end

  context 'length of password' do
    it { should validate_length_of(:password).is_at_least(6) }
  end

  context 'secure password' do
    it { should have_secure_password }
  end

  describe 'squish_whitespace' do
    let(:name) { '   A       B C   ' }
    let(:password) { 'Aa123456' }
    let(:address) { '   X   Y   Z   ' }
    let!(:user) do
      create(:user, name: name,
                    address: address,
                    password: password,
                    password_confirmation: password)
    end

    it 'squish_whitespace' do
      expect(User.last.name).to eql('A B C')
      expect(User.last.address).to eql('X Y Z')
    end
  end
end
