require 'rails_helper'
RSpec.describe SessionsHelper, type: :helper do
  let(:current_user) { create(:user) }

  before do
    allow(User).to receive(:find_by).with(anything).and_return(current_user)
  end
end
