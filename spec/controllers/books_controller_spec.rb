require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  let(:image_files) do
    image_files = []
    rand(1..3).times do
      image_files << Rack::Test::UploadedFile.new(
        Rails.root.join('spec/support/default-book-cover.jpg'),
        'image/jpeg'
      )
    end
    image_files
  end

  let(:book_params) { create(:book) }

  let(:valid_book_params) do
    {
      name: book_params.name,
      price: book_params.price,
      description: book_params.description,
      quantity: book_params.quantity,
      comment: book_params.comment,
      files: image_files
    }
  end

  let(:invalid_book_params) { { name: nil } }

  describe '#index' do
    before { get :index }

    context 'has no book' do
      it 'assigns empty to books' do
        expect(assigns(:books)).to be_empty
      end
    end

    context 'has many books' do
      before do
        3.times do
          create(:book)
        end
      end

      it 'should be received enough book' do
        expect(assigns(:books).count).to equal(Book.count)
      end

      it 'should be received correct book' do
        expect(assigns(:books).pluck(:id)).to match_array(Book.all.pluck(:id))
      end
    end
  end

  describe '#show' do
    before do
      @book = create(:book)
    end
    context 'book is existing' do
      it "should be received book's info" do
        get :show, params: { id: @book.id }
        expect(assigns(:book).attributes).to eql(@book.attributes)
      end
    end

    context 'book is not existing' do
      before do
        allow(Book).to receive(:find_by).with(anything).and_return(nil)
        get :show, params: { id: @book.id }
      end

      it 'should be received a nil object' do
        expect(assigns(:book)).to equal(nil)
      end

      it 'should be received a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#new' do
    context 'after login' do
      include_context 'logged in'
      it 'get a instace of Book' do
        get :new
        expect(assigns(:book)).to be_a(Book)
      end
    end

    context 'before login' do
      before do
        get :new
      end
      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#create' do
    include_context 'logged in'
    before do
      book_params
      @book_count = Book.count
    end
    context 'with valid book_params' do
      subject { post :create, params: { book: valid_book_params } }
      before do
        post :create, params: { book: valid_book_params }
      end

      it 'the number of book is increment by 1' do
        expect { subject }.to change(Book, :count).by(1)
      end

      it 'new book is created with correct data' do
        expect(Book.last.name).to eql(book_params.name)
        expect(Book.last.quantity).to eql(book_params.quantity)
        expect(Book.last.price).to eql(book_params.price)
        expect(Book.last.comment).to eql(book_params.comment)
        expect(Book.last.description).to eql(book_params.description)
      end

      it 'new book is given enough image file' do
        expect(Book.last.images.count).to eql(image_files.count)
      end

      it 'get a success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('books.created'))
      end

      it 'redirect to new book' do
        expect(subject).to redirect_to(Book.last)
      end
    end

    context 'with invalid book_params' do
      before do
        post :create, params: { book: invalid_book_params }
      end

      it 'the number of book is constant' do
        expect(Book.count).to equal(@book_count)
      end

      it "should be reder to 'new'" do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    context 'before login' do
      before do
        book = create(:book)
        get :edit, params: { id: book.id }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context 'with invalid book' do
      include_context 'logged in'
      before do
        allow(Book).to receive(:find_by).with(anything).and_return(nil)
        get :edit, params: { id: 1 }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context "current_user not be book's owner" do
      include_context 'logged in'
      before do
        user = create(:user)
        @book = create(:book, user_id: user.id)
        get :edit, params: { id: @book.id }
      end

      it 'return root page' do
        expect(subject).to redirect_to(root_url)
      end

      it 'get a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end
    end

    context "after login as book's owner" do
      include_context 'logged in'
      before do
        @book = create(:book, user_id: current_user.id)
        get :edit, params: { id: @book.id }
      end
      it 'get the correct book' do
        expect(assigns(:book).attributes).to eql(@book.attributes)
      end
    end
  end

  describe '#update' do
    include_context 'logged in'
    before do
      @book = create(:book, user_id: current_user.id)
    end

    context 'with valid book params' do
      before do
        put :update, params: { id: @book.id, book: valid_book_params }
      end

      it 'the book has newest data' do
        expect(assigns(:book).name).to eql(book_params.name)
        expect(assigns(:book).quantity).to eql(book_params.quantity)
        expect(assigns(:book).price).to eql(book_params.price)
        expect(assigns(:book).comment).to eql(book_params.comment)
        expect(assigns(:book).description).to eql(book_params.description)
      end

      it 'the book is given enough image file' do
        expect(@book.images.count).to eql(image_files.count)
      end

      it 'get a success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book.updated'))
      end

      it 'redirect to @book' do
        expect(subject).to redirect_to(@book)
      end
    end

    context 'with invalid book params' do
      before do
        @book_origin = @book
        put :update, params: { id: @book.id, book: invalid_book_params }
      end

      it 'the book not be update' do
        assigns(:book).reload
        expect(assigns(:book).name).to eql(@book_origin.name)
        expect(assigns(:book).quantity).to eql(@book_origin.quantity)
        expect(assigns(:book).price).to eql(@book_origin.price)
        expect(assigns(:book).comment).to eql(@book_origin.comment)
        expect(assigns(:book).description).to eql(@book_origin.description)
      end

      it 'reder to :edit' do
        expect(subject).to render_template(:edit)
      end
    end

    context 'book is updated with no images' do
      before do
        put :update, params: { id: @book.id, book: invalid_book_params }
      end

      it 'all book images are deleted' do
        expect(assigns(:book).images.count).to eql(0)
      end
    end
  end
end
