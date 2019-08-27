require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe '#update' do
    let(:token) {  SecureRandom.urlsafe_base64.split('.').join }
    let(:request_sent_at) { Time.zone.now }
    let(:password) { '123456' }
    let(:password_confirmation) { '123456' }
    let(:user) do
      user = {password: password, password_confirmation: password_confirmation}
    end

    before do
      user = create(:user)
      user.update_attribute(:password_reset_token, token)
      user.update_attribute(:password_reset_sent_at, request_sent_at)
      binding.pry
    end

    subject do
      put :update, params:{ user: user }
    end

    context 'Reset password successfully' do
      it 'Return reset passwor successfully flash' do
        subject
        binding.pry
        expect(flash.count).to eql(1)
        expect(flash[:danger]).to eql(I18n.t('password_reset.sucess'))
      end
    end
  end
end
