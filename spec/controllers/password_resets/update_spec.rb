require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '#update' do
    let(:token) {  SecureRandom.urlsafe_base64.split('.').join }
    let(:request_sent_at) { Time.zone.now }
    let!(:user) { create(:user) }
    before do
      user.update_attribute(:password_reset_token, token)
      user.update_attribute(:password_reset_sent_at, request_sent_at)
    end

    context 'Reset password successfully' do
      let(:user_params) do
        user_params = { password: '123456', password_confirmation: '123456' }
      end

      before { put :update, params: { id: token, user: user_params } }

      it 'Return reset passwor successfully flash' do
        expect(flash.count).to eql(1)
        expect(flash[:success]).to eql(I18n.t('password_reset.sucess'))
      end

      it 'Redirect to root path' do
        expect(subject).to redirect_to(root_path)
      end

      it 'Reset password token to be nil' do
       expect(assigns(:user).password_reset_token).to be_nil
      end
    end

    context 'Password not match' do
      let(:user_params) do
        user_params = { password: '123456', password_confirmation: '123457' }
      end

      before { put :update, params: { id: token, user: user_params } }

      it 'Return reset passwor successfully flash' do
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('password_reset.password_not_match'))
      end

      it 'Render edit template' do
        expect(subject).to render_template(:edit)
      end
    end

    context 'Reset password fail' do
      let(:user_params) do
        user_params = { password: '123456', password_confirmation: '123456' }
      end

      before do
        allow_any_instance_of(User).to receive(:update_attributes).with(anything).and_return(false)
        put :update, params: { id: token, user: user_params }
      end

      it 'Return reset passwodr false flash' do
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('password_reset.error'))
      end
    end
  end
end
