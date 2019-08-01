RSpec.describe BookRequestsController, type: :controller do
  describe '#index' do
    before { get :index }

    context 'many book requests' do
      before do
        rand(5..15).times do
          create(:book_request)
        end
      end

      it 'return right number of book requests' do
        expect(assigns(:book_requests).count).to eql(BookRequest.count)
      end

      it 'data of book request is exactly' do
        expect(assigns(:book_requests)
          .pluck(:id)).to eql(BookRequest.all.pluck(:id))
      end
    end

    context 'has no book requests' do
      it 'has no book request' do
        expect(assigns(:book_requests)).to be_empty
      end
    end
  end
end
