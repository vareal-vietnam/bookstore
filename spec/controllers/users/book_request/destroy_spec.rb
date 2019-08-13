require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  include_context 'logged in'

  describe '#destroy' do
    before do
      5.times do
        create(:book_request)
      end
    end

    context 'book request found' do
      let!(:book_request) do
        book_request = create(:book_request, user_id: current_user.id)
        3.times do
          create(:book_request_image, book_request_id: book_request.id)
        end
        book_request
      end

      subject do
        delete :destroy, params: {
          user_id: current_user.id, id: book_request.id
        }
      end

      it 'total book request decrement by 1' do
        expect { subject }.to change(BookRequest, :count).by(-1)
      end

      it 'return delete success flash' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('action.delete.success'))
      end

      it "redirect to user's book requests index page" do
        subject
        expect(subject)
          .to redirect_to(user_book_requests_url(current_user))
      end

      it 'all images of book request deleted' do
        expect { subject }
          .to change(BookRequestImage, :count)
          .by(book_request.book_request_images.count * -1)
      end

      context 'destroy not successfully' do
        before do
          allow_any_instance_of(BookRequest).to receive(:destroy)
            .and_return(false)
        end

        it 'return delete fail flash' do
          subject
          expect(flash.count).to equal(1)
          expect(flash[:danger])
            .to eql(I18n.t('action.delete.fail'))
        end

        it "redirect to user's book requests index page" do
          expect(subject).to redirect_to(user_book_requests_url(current_user))
        end
      end
    end

    context 'book request not found' do
      before do
        delete :destroy, params: {
          user_id: current_user.id, id: BookRequest.last.id + 10
        }
      end

      it 'return book request not exist flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger])
          .to eql(I18n.t('book_requests.not_exist'))
      end

      it "redirect to user's book requests index page" do
        expect(subject).to redirect_to(user_book_requests_url(current_user))
      end
    end
  end
end
