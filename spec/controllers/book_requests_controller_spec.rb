require 'rails_helper'
RSpec.describe BookRequestsController, type: :controller do
  let(:book_request_params) { create(:book_request) }
  let(:image_files) do
    image_files = []
    rand(0..3).times do
      image_files << Rack::Test::UploadedFile.new(
        Rails.root.join('spec/support/default-book-cover.jpg'),
        'image/jpeg'
      )
    end
    image_files
  end
  let(:valid_book_request_params) do
    {
      name: book_request_params.name,
      budget: book_request_params.budget,
      quantity: book_request_params.quantity,
      comment: book_request_params.comment,
      book_request_images: image_files
    }
  end
  let(:invalid_book_request_params) { { name: nil } }
  describe '#create' do
    include_context 'logged in'
    context 'has valid params' do
      subject do
        post :create, params: { book_request: valid_book_request_params }
      end
      before do
        post :create, params: { book_request: valid_book_request_params }
      end
      it 'total book request increase by 1' do
        expect { subject }.to change(BookRequest, :count).by(1)
      end
      it 'give success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book_requests.create.success'))
      end
      it 'book request images save enough image ' do
        expect(BookRequest.last.book_request_images.count)
          .to eql(image_files.count)
      end
      it 'data must be inserted exactly' do
        expect(BookRequest.last.name).to eql(book_request_params.name)
        expect(BookRequest.last.comment).to eql(book_request_params.comment)
        expect(BookRequest.last.quantity).to eql(book_request_params.quantity)
        expect(BookRequest.last.budget).to eql(book_request_params.budget)
      end
      it 'redirect to root url' do
        expect(subject).to redirect_to(root_url)
      end
    end
    context 'has invalid params' do
      subject do
        post :create, params: { book_request: invalid_book_request_params }
      end
      before do
        post :create, params: { book_request: invalid_book_request_params }
      end
      it 'total book request not change' do
        expect { subject }.to change(BookRequest, :count).by(0)
      end
      it "should be reder to 'new'" do
        expect(subject).to render_template(:new)
      end
    end
  end
end
