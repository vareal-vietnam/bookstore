require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include_context 'logged in'
  let(:other_user) { create(:user) }
  let(:valid_user_params) do
    user_params = attributes_for(:user)
    {
      name: user_params[:name],
      phone: user_params[:phone],
      address: user_params[:address],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation],
      avatar: user_params[:avatar]
    }
  end

  let(:invalid_user_params) { { name: nil } }

  describe '#show' do
    context 'user have not logged in' do
      subject { get :show, params: { id: other_user.id } }
      before do
        allow(User).to receive(:find_by).with(anything).and_return(nil)
      end
      it 'redirect to home' do
        expect(subject).to redirect_to(root_url)
      end

      it 'returns flash' do
        subject
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context 'not current user' do
      subject { get :show, params: { id: other_user.id } }
      it 'flash and returns to home page' do
        subject
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
      it 'redirect to home' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'current user' do
      random_number = rand(10)
      before do
        random_number.times do
          @book = create(:book, user_id: current_user.id)
        end
      end
      it "quantity of book must equal quantity of user's book" do
        expect(current_user.books.count).to eql(random_number)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      subject { post :create, params: { user: valid_user_params } }

      it 'flash success' do
        subject
        expect(flash[:success]).to eql(I18n.t('.users.create.user_created'))
      end

      it 'redirect to created user' do
        expect(subject).to redirect_to(User.last)
      end

      it "attributes must comply with created user's attributes" do
        subject
        expect(assigns(:user).attributes).to eql(User.last.attributes)
      end

      it 'the quantity of user increase 1' do
        expect { subject }.to change { User.count }.by(1)
      end
    end

    context 'with invalid params' do
      subject { post :create, params: { user: invalid_user_params } }

      it 'user quantity not increase' do
        expect { subject }.to change { User.count }.by(0)
      end

      it 'render to new user template' do
        expect(subject).to render_template(:new)
      end

      it 'get danger flash' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('.users.create.user_create_fail'))
      end
    end
  end
end
