module ImagesHelper
  def get_thumb_url(soure)
    if soure.is_a? Book
      image = soure.images.first
    elsif soure.is_a? BookRequest
      image = soure.book_request_images.first
    end
    if image
      image.thumb_url
    else
      image_path('default-book-cover.jpg')
    end
  end
end
