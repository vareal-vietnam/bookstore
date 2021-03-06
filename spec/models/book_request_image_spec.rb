require 'rails_helper'

RSpec.describe BookRequestImage, type: :model do
  it { should validate_presence_of(:file) }
  it { should belong_to(:book_request) }
end
