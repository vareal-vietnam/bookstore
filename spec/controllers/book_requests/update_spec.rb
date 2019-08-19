require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  include_context 'generate book_request_params'

  let(:book_request) { create(:book_request, user_id: current_user.id) }

  describe '#update' do
    include_context 'logged in'
    context 'valid invalid params' do
      subject do
        put :update, params: {
          id: book_request.id,
          book_request: invalid_book_request_params
        }
      end
      it 'book request not change' do
        expect { subject }.to_not change(book_request, :reload)
      end

      it 'should be render to edit' do
        expect(subject).to render_template(:edit)
      end
    end

    context 'with valid params with images' do
      subject do
        put :update, params: {
          id: book_request.id,
          book_request: valid_book_request_params
        }
      end

      it 'book request have newest data' do
        subject
        expect(assigns(:book_request).attributes)
          .to include(book_request_params.stringify_keys)
      end

      it 'the book is given enough image file' do
        subject
        expect(assigns(:book_request)
          .book_request_images.count).to eql(image_files.count)
      end

      it 'return flash update success' do
        subject
        expect(flash.count).to eq(1)
        expect(flash[:success]).to eql(I18n.t('book_requests.update.success'))
      end

      it 'redirect to view detail' do
        subject
        expect(subject)
          .to redirect_to(book_request_url(book_request))
      end
    end

    context 'with valid params and no image' do
      subject do
        put :update, params: {
          id: book_request.id,
          book_request: valid_book_request_params_no_image
        }
      end

      it 'book request have newest data' do
        subject
        expect(assigns(:book_request)
          .attributes).to include(book_request_params.stringify_keys)
      end

      it 'the book request images no change' do
        expect { subject }.to_not change(book_request, :book_request_images)
      end

      it 'return flash update success' do
        subject
        expect(flash.count).to eq(1)
        expect(flash[:success]).to eql(I18n.t('book_requests.update.success'))
      end

      it 'redirect to view detail' do
        subject
        expect(subject)
          .to redirect_to(book_request_url(book_request))
      end
    end
  end
end
