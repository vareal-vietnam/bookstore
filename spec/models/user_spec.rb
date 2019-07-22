require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:phone) }
  end
  context 'length of password' do
    it { should validate_length_of(:password).is_at_least(6) }
  end
  context 'secure password' do
    it { should have_secure_password }
  end
end
