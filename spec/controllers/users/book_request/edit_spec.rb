require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  include_context 'generate book_request_params'
  describe '#edit' do
    include_context 'logged in'
    context 'has valid params' do
      subject do
        get :edit, params: { user_id: current_user.id, id: valid_book_request_params.id}
      end
    end
  end
end
