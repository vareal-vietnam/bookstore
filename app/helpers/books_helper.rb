module BooksHelper
  def get_thumb_url(book)
    if book.images.empty?
      image_path('default-book-cover.jpg')
    else
      book.images.first.thumb_url
    end
  end
end
