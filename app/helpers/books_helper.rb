module BooksHelper
  def get_thumb_url(book)
    image = book.images.first
    if image
      image.thumb_url
    else
      image_path('default-book-cover.jpg')
    end
  end
end
