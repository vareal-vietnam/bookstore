require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include_context 'logged in'
  let(:other_user) { create(:user) }
  let!(:user_count) { User.count }
  let(:user) { User.last }
  let(:n) { rand(100) }
  describe '#show' do
    context 'not current user' do
      before do
        post :show, params: {
          id: other_user.id
        }
      end
      it 'flash and returns to home page' do
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
      it 'redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end
    context 'current user' do
      before do
        n.times do
          @book = create(:book, user_id: current_user.id)
        end
      end

      it "quantity of book must equal quantity of user's book" do
        expect(current_user.books.count).to eql(n)
      end
    end
  end
  describe '#create' do
    context 'with valid params' do
      before do
        @user = build(:user)
        post 'create', params: {
          user: {
            name: @user.name,
            phone: @user.phone,
            address: @user.address,
            password: @user.password,
            password_confirmation: @user.password_confirmation,
            avatar: @user.avatar
          }
        }
      end
      it 'flash success' do
        expect(flash[:success]).to eql(I18n.t('.users.create.user_created'))
      end
      it 'redirect to created user' do
        expect(subject).to redirect_to(user_path(id: User.last.id))
      end
      it "attributes must comply with created user's attributes" do
        expect(assigns(:user).attributes).to eql(User.last.attributes)
      end

      it 'the quantity of user increase 1' do
        expect(user_count + 1).to equal(User.count)
      end
    end

    context 'with invalid params' do
      before do
        @user = build(:user)
        post 'create', params: {
          user: {
            name: nil,
            phone: @user.phone,
            address: @user.address,
            password: @user.password,
            password_confirmation: @user.password_confirmation,
            avatar: @user.avatar
          }
        }
      end
      it 'user quantity not increase 1' do
        expect(user_count).to equal(User.count)
      end
      it 'render to new user template' do
        expect(subject).to render_template(:new)
      end
      it 'get danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('.users.create.user_create_fail'))
      end
    end
  end

  describe '#edit' do
    context 'with same user' do
      before do
        get 'edit', params: { id: current_user.id }
      end

      it 'expect has no flash message' do
        expect(flash.count).to equal(0)
      end
    end

    context 'with different user' do
      before do
        other_user = create(:user)
        get 'edit', params: { id: other_user.id }
      end

      it 'gets danger flash message' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      before do
        @user = build(:user)
        put 'update', params: {
          id: current_user.id,
          user: {
            name: @user.name,
            address: @user.address,
            password: @user.password,
            password_confirmation: @user.password_confirmation,
            avatar: @user.avatar
          }
        }
      end

      it 'user has newest data' do
        expect(current_user.name).to eql(@user.name)
        expect(current_user.address).to eql(@user.address)
        expect(current_user.password).to eql(@user.password)
        expect(current_user.avatar&.url).to eql(@user.avatar&.url)
      end

      it 'gets success flash message' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('users.update.update_success'))
      end

      it 'should be redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end

    context 'with invalidate user_params' do
      before do
        @user = build(:user)
        put 'update', params: {
          id: current_user.id,
          user: {
            name: nil,
            address: @user.address,
            password: @user.password,
            password_confirmation: @user.password_confirmation,
            avatar: @user.avatar
          }
        }
      end

      it 'should be render to edit' do
        expect(subject).to render_template(:edit)
      end

      it 'user not be updated' do
        current_user.reload
        expect(current_user.name).to_not eql(@user.name)
        expect(current_user.address).to_not eql(@user.address)
        expect(current_user.password_digest).to_not eql(@user.password_digest)
        # TODO
        # expect(current_user.avatar&.url).to_not eql(@user.avatar&.url)
      end
    end
  end
end

