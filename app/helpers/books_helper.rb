module BooksHelper
  def get_thumb_url(book)
    if book.images.first
      book.images.first.thumb_url
    else
      image_path('default-book-cover.jpg')
    end
  end
end
