RSpec.shared_context 'logged in' do
  let(:current_user) { create(:user) }

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(current_user)
  end
end
