require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include_context 'logged in'

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
        # To do
        # expect(current_user.avatar&.url).to_not eql(@user.avatar&.url)
      end
    end
  end
end
