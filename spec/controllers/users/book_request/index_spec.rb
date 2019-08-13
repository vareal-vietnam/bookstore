require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  let(:page_number) { 2 }
  let(:random_id) { rand(1..20) }

  describe '#index' do
    context 'before log in' do
      before { get :index, params: { user_id: random_id } }

      it 'return flash require log in' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('warning.need_log_in'))
      end

      it 'redirect to root page' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'after log in' do
      include_context 'logged in'

      context 'after log in with valid user id' do
        before do
          get :index, params: {
            user_id: current_user.id, page: page_number
          }
        end

        context 'user have many book request' do
          let(:book_requests) { current_user.book_requests }
          before do
            20.times do
              create(:book_request, user_id: current_user.id)
            end
          end

          it 'return right number of book requests' do
            expected_book_requests =
              book_requests.order(created_at: :desc)
                           .includes(:book_request_images, :user)
                           .page(page_number).per(16)
            expect(assigns(:book_requests)
            .pluck(:id)).to eql(expected_book_requests.pluck(:id))
          end
        end

        context 'user do not have any book request' do
          it 'has no book request' do
            expect(assigns(:book_requests)).to be_empty
          end
        end
      end

      context 'with invalid user id' do
        let(:other_user) { create(:user) }

        context 'user not exist' do
          before { get :index, params: { user_id: other_user.id + 10 } }

          it 'return user not exist flash' do
            expect(flash.count).to eql(1)
            expect(flash[:danger]).to eql(I18n.t('warning.user_not_exist'))
          end

          it 'redirect to root url' do
            expect(subject).to redirect_to(root_url)
          end
        end

        context 'user not enough permission' do
          before { get :index, params: { user_id: other_user.id } }

          it 'return not enough permission' do
            expect(flash.count).to eql(1)
            expect(flash[:danger]).to eql(I18n.t('warning.not_permission'))
          end

          it 'redirect to root url' do
            expect(subject).to redirect_to(root_url)
          end
        end
      end
    end
  end
end
