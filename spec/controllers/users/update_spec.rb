require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include_context 'logged in'
  include_context 'assign user'

  let(:valid_params_update_info) do
    user_params = attributes_for(:user)
    {
      name: user_params[:name],
      address: user_params[:address],
      password: user_params[:password],
    }
  end

  let(:valid_params_update_password) do
    user_params = attributes_for(:user)
    {
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation]
    }
  end

  describe '#update' do
    context 'with valid params update info' do
      before do
        put :update, params: { id: current_user.id, user: valid_params_update_info }
      end

      it 'user has newest data' do
        expect(current_user.name).to eql(valid_params_update_info[:name])
        expect(current_user.address).to eql(valid_params_update_info[:address])
      end

      it 'gets success flash message' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('users.update.update_success'))
      end

      it 'should be redirect to current_user' do
        expect(subject).to redirect_to(current_user)
      end
    end

    context 'valid params update password' do
      before do
        put :update, params: { id: current_user.id, user: valid_params_update_password }
      end

      it 'user has newest password' do
        expect(current_user.password).to eql(valid_params_update_password[:password])
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
      subject do
        put :update, params: { id: current_user.id, user: invalid_user_params }
      end

      it 'should be render to edit' do
        subject
        expect(subject).to render_template(:edit)
      end

      it 'user not be updated' do
        expect { subject }.to_not change(current_user, :reload)
      end
    end
  end
end
