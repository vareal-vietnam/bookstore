require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  let(:password) { 'Aa123456' }
  let(:other_password) { 'Aa00000' }
  let(:user) do
    create(:user, password: password, password_confirmation: password)
  end

  describe '#create' do
    subject do
      post :create, params: {
        session: {
          phone: user.phone,
          password: password
        }
      }
    end

    context 'valid param input' do
      it 'flash login success' do
        subject
        expect(flash[:success]).to eql(I18n.t('.sessions.create.success_login'))
      end

      it 'redirect to logged in user' do
        expect(subject).to redirect_to(user)
      end
    end

    context 'invalid param input' do
      subject do
        post :create, params: {
          session: {
            phone: user.phone,
            password: other_password
          }
        }
      end

      it 'flash login fail' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:warning])
          .to eql(I18n.t('.sessions.create.wrong_password'))
      end

      it 'render to new' do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    include_context 'logged in'
    before do
      session[:user_id] = current_user.id
    end

    context 'user log_out' do
      subject { delete :destroy }

      it 'session of current user will be removed' do
        subject
        expect(session[:user_id]).to eql(nil)
      end

      it 'current user will be removed' do
        subject
        expect(assigns(:current_user)).to eql(nil)
      end

      it 'redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end
end
