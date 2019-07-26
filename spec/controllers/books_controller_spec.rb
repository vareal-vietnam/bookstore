require 'rails_helper'
RSpec.describe BooksController, type: :controller do
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

      it 'should be return home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#new' do
    context 'after login' do
      include_context 'logged in'
      it 'should be received a instace of Book' do
        get :new
        expect(assigns(:book)).to be_a(Book)
      end
    end

    context 'before login' do
      before do
        get :new
      end
      it 'should be received a danger flash' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'should be return home' do
        expect(subject).to redirect_to(root_url)
      end
    end
  end

  describe '#create' do
    include_context 'logged in'
    context 'with valid book_params' do
      before do
        @book_params = create(:book)
        @book_count = Book.count
        @files = []
        rand(1..3).times do
          @files << Rack::Test::UploadedFile.new(
            Rails.root.join('spec/support/default-book-cover.jpg'),
            'image/jpeg'
          )
        end

        post :create, params: {
          book: {
            name: @book_params.name,
            price: @book_params.price,
            description: @book_params.description,
            quantity: @book_params.quantity,
            comment: @book_params.comment,
            files: @files
          }
        }
      end

      it 'the number of book is increment by 1' do
        expect(Book.count).to equal(@book_count + 1)
      end

      it 'new book is created with correct data' do
        expect(Book.last.name).to eql(@book_params.name)
        expect(Book.last.quantity).to eql(@book_params.quantity)
        expect(Book.last.price).to eql(@book_params.price)
        expect(Book.last.comment).to eql(@book_params.comment)
        expect(Book.last.description).to eql(@book_params.description)
      end

      it 'new book is given enough image file' do
        expect(Book.last.images.count).to eql(@files.count)
      end

      it 'should be received a success flash' do
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('books.created'))
      end

      it 'should be redirect to new book' do
        expect(subject).to redirect_to(Book.last)
      end
    end

    context 'with invalid book_params' do
      before do
        @book_params = create(:book)
        @book_count = Book.count
        @files = []
        rand(1..3).times do
          @files << Rack::Test::UploadedFile.new(
            Rails.root.join('spec/support/default-book-cover.jpg'),
            'image/jpeg'
          )
        end

        post :create, params: {
          book: {
            name: nil,
            price: @book_params.price,
            description: @book_params.description,
            quantity: @book_params.quantity,
            comment: @book_params.comment,
            files: @files
          }
        }
      end

      it 'the number of book is constant' do
        expect(Book.count).to equal(@book_count)
      end

      it "should be reder to 'new'" do
        expect(subject).to render_template(:new)
      end
    end
  end
end
