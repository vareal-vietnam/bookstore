require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe 'create user' do
    before do
      @user_count = User.count
      post :create, params: {
        user: {
          name: 'Cuong', phone: '0912458147', address: 'abc',
          password: '123456', password_confirmation: '123456', avatar: ''
        }
      }
    end
    context 'with valid params' do
      it 'flash success' do
        expect(flash[:success]).to eql(I18n.t('.users.create.user_created'))
      end
      it 'redirect to created user' do
        user = User.last
        expect(subject).to redirect_to(user_path(id: user.id))
        expect(assigns(:user).attributes).to eql(user.attributes)
      end
      it 'the quantity increase 1' do
        expect(User.count).to equal(@user_count + 1)
      end
    end
  end
end
