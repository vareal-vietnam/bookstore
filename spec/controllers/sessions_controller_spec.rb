require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  let(:password) { 'Aa123456' }
  let(:other_password) { 'Aa00000' }
  describe '#create' do
    before do
      user = create(:user, password: password,
                           password_confirmation: password)
      post :create, params: {
        session: {
          phone: user.phone,
          password: password
        }
      }
    end
    context 'valid param input' do
      it 'flash login success' do
        expect(flash[:success]).to eql(I18n.t('.sessions.create.success_login'))
      end
    end
    context 'invalid param input' do
      before do
        user = create(:user, password: password,
                             password_confirmation: password)
        post :create, params: {
          session: {
            phone: user.phone,
            password: other_password
          }
        }
      end
      it 'flash login fail' do
        expect(flash[:warning]).to
        eql(I18n.t('.sessions.create.wrong_password'))
      end
    end
  end
end
