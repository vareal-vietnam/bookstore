module BooksHelper
  def get_thumb_url(book)
    image = book.images.first
    image.thumb_url
  end
end
