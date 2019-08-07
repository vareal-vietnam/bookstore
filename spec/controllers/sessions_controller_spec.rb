require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
  include_context 'user_login_params'
  describe '#create' do
    context 'invalid params input' do
      subject do
        post :create, params: {
          session: invalid_user_params
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

    context 'valid params input not checked remember me' do
      subject do
        post :create, params: {
          session: valid_user_params_unchecked_remember_me
        }
      end

      it 'remember_disgest must be nil' do
        subject
        expect(user[:remember_digest]).to eql(nil)
      end

      it 'the user_id and remember_token of the cookie must be nil' do
        subject
        expect(cookies[:user_id]).to eql(nil)
        expect(cookies[:remember_token]).to eql(nil)
      end

      it 'flash login success' do
        subject
        expect(flash[:success]).to eql(I18n.t('.sessions.create.success_login'))
      end

      it 'redirect to logged in user' do
        expect(subject).to redirect_to(user)
      end

      it 'session id must be created' do
        subject
        expect(session[:user_id]).to eql(user.id)
      end
    end

    context 'valid params input and checked remember me' do
      subject do
        post :create, params: {
          session: valid_user_params_checked_remember_me
        }
      end

      it 'remember_disgest not be nil' do
        subject
        expect(user.reload[:remember_digest]).not_to eql(nil)
      end

      it 'the user_id and remember_token of the cookie not be nil' do
        subject
        expect(cookies[:user_id]).not_to eql(nil)
        expect(cookies[:remember_token]).not_to eql(nil)
      end

      it 'flash login success' do
        subject
        expect(flash[:success]).to eql(I18n.t('.sessions.create.success_login'))
      end

      it 'redirect to logged in user' do
        expect(subject).to redirect_to(user)
      end

      it 'session id must be created' do
        subject
        expect(session[:user_id]).to eql(user.id)
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

      it 'remember_disgest of current_user be nil' do
        subject
        expect(current_user[:remember_digest]).to eql(nil)
      end

      it 'the user_id and remember_token of the cookie must be nil' do
        subject
        expect(cookies[:user_id]).to eql(nil)
        expect(cookies[:remember_token]).to eql(nil)
      end
    end
  end
end
