require 'rails_helper'
RSpec.describe PaginationHelper, type: :helper do
  let(:total_books) { 15 }
  let(:per_page) { 2 }
  let(:total_pages) do
    if (total_books % per_page) != 0
      total_books / per_page + 1
    else
      total_books / per_page
    end
  end
  let(:item_of_last_page) do
    if (total_books % per_page) == 0
      per_page
    else
      total_books % per_page
    end
  end
  let(:valid_page) { total_pages - 1 }
  let(:invalid_page) { total_pages + 1 }
  let(:collection) { Book.all }
  let!(:books) do
    total_books.times do
      create(:book)
    end
  end

  describe '#paginate_collection' do
    context 'with normal valid page' do
      subject do
        paginate_collection(collection, valid_page, per_page)
      end

      it 'received enough book' do
        expect(subject.count).to eq(per_page)
      end

      it 'received correct data' do
        expect_data = collection.page(valid_page).per(per_page)
        expect(subject).to match_array(expect_data)
      end
    end

    context 'with last page' do
      subject do
        paginate_collection(collection, total_pages, per_page)
      end

      it 'received enough item' do
        expect(subject.count).to eq(item_of_last_page)
      end

      it 'received correct data' do
        expect(subject).to match_array(collection.last(item_of_last_page))
      end
    end

    context 'with invalid page' do
      subject do
        paginate_collection(collection, invalid_page, per_page)
      end

      it 'received total item of last page' do
        expect(subject.count).to eq(item_of_last_page)
      end

      it 'received data of last page' do
        expect(subject).to match_array(collection.last(item_of_last_page))
      end
    end
  end
end
