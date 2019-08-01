RSpec.describe BookRequestsController, type: :controller do
  describe '#index' do
    context 'have book requests' do
      # let(:latest_requests) { BookRequest.all.limit(20).to_a }
      let(:latest_requests) { BookRequest.all.limit(20).to_a }
      binding.pry
      before { get :index }

      it 'returns right number of book requests' do
        expect(assigns(:book_requests).count).to equal(latest_requests.count)
      end

      it 'data of book request is exactly' do

        # expect(assigns(:book_requests).pluck(:id))
        #   .to match_array(BookRequest.all.pluck(:id))
        # expect(assigns(:book_requests).pluck(:user_id))
        #   .to match_array(BookRequest.all.pluck(:user_id))
        # expect(assigns(:book_requests).pluck(:budget))
        #   .to match_array(BookRequest.all.pluck(:budget))
        # expect(assigns(:book_requests).pluck(:quantity))
        #   .to match_array(BookRequest.all.pluck(:quantity))
        # expect(assigns(:book_requests).pluck(:comment))
        #   .to match_array(BookRequest.all.pluck(:comment))
      end
    end

    context 'do not have any book request' do
      it 'no book request is given' do
        # expect(assigns(:book_requests)).to be_empty
      end
    end
  end
end
