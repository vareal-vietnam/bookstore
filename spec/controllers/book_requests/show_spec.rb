require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  describe '#show' do
    let(:page) { 2 }
    let(:path) { "#{book_requests_url}?page=#{page}" }

    context 'book request found' do
      let(:book_request) { create(:book_request) }
      before { get :show, params: { id: book_request.id } }
      it 'return right book request' do
        expected_book_request = BookRequest.find_by(id: book_request.id)
        expect(assigns(:book_request).attributes)
          .to eql(expected_book_request.attributes)
      end
    end

    context 'book request not found' do
      let!(:book_request) { create(:book_request) }
      before { get :show, params: { id: BookRequest.last.id + 1, page: page } }

      it 'return flash not found' do
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('book_requests.not_exist'))
      end

      it 'redirect to book request index' do
        expect(subject).to redirect_to(path)
      end
    end
  end
end
