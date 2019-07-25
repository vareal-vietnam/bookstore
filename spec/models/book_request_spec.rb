require 'rails_helper'

RSpec.describe BookRequest, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:budget) }
end
