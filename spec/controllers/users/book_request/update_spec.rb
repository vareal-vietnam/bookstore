require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  include_context 'generate book_request_params'
  let(:book_request) { create(:book_request, user_id: current_user.id) }
  describe '#update' do
    include_context 'logged in'
    context 'valid invalid params' do
      subject do
        put :update, params: {
          user_id: current_user.id, id: book_request.id,
          book_request: invalid_book_request_params
        }
      end
      it 'number of book request not change' do
        subject
        expect { subject }.to change(BookRequest, :count).by(0)
      end

      it 'should be reder to edit' do
        expect(subject).to render_template(:edit)
      end
    end

    context 'with valid params' do
      subject do
        put :update, params: {
          user_id: current_user.id, id: book_request.id,
          book_request: valid_book_request_params
        }
      end

      it 'number of book request not change' do
        subject
        expect { subject }.to change(BookRequest, :count).by(0)
      end

      it 'return flash update success' do
        subject
        expect(flash.count).to eq(1)
        expect(flash[:success]).to eql(I18n.t('book_requests.update.success'))
      end

      it 'return redirect to view detail' do
        subject
        expect(subject).
          to redirect_to(user_book_request(current_user, id, book_request.id))
      end
    end
  end
end
