require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BooksHelper. For example:
#
# describe BooksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BooksHelper, type: :helper do
  let(:book) { create(:book) }
  let!(:image) { create(:image, book_id: book.id) }

  describe '#get_thumb_url' do
    it 'returns first book image thumb url' do
      expect(book.images.first.thumb_url).to eql(get_thumb_url(book))
    end
  end
end
