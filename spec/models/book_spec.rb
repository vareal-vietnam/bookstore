require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:quantity) }
  it { should have_many(:images).dependent(:destroy) }
  it { should validate_numericality_of(:quantity).only_integer }
  it do
    should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0)
  end
  it do
    should validate_numericality_of(:quantity).is_less_than_or_equal_to(1000)
  end
  it { should validate_numericality_of(:price).only_integer }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it do
    should validate_numericality_of(:price).is_less_than_or_equal_to(99_999_000)
  end
end
