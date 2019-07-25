require 'rails_helper'

RSpec.describe BookRequest, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:budget) }
  it { should belong_to(:user) }
  it { should validate_numericality_of(:quantity).only_integer }
  it do
    should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
  end
  it { should validate_numericality_of(:budget).only_integer }
  it do
    should validate_numericality_of(:budget).is_greater_than_or_equal_to(0)
  end
end
