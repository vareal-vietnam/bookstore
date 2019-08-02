RSpec.describe BookRequestsController, type: :controller do
  describe '#index' do
    before { get :index, params: { page: 2 } }

    context 'has many book requests' do
      before do
        20.times do
          create(:book_request)
        end
      end

      it 'return right number of book requests' do
        expected_book_requests =
          BookRequest.order(created_at: :desc).page(2).per(15)
        expect(assigns(:book_requests)
          .pluck(:id)).to eql(expected_book_requests.pluck(:id))
      end
    end

    context 'no book requests' do
      it 'has no book request' do
        expect(assigns(:book_requests)).to be_empty
      end
    end
  end
end
