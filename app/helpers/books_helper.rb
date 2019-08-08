module BooksHelper
  def get_thumb_url(book)
    if images.empty?
      book.image_path('default-book-cover.jpg')
    else
      book.images.first.thumb_url
    end
  end
end
