RSpec.shared_context 'login user' do
  let(:current_user) { create(:user) }

  before do
    allow(User).to receive(:find_by).with(anything).and_return(current_user)
  end
end
