class BookRequestImage < ApplicationRecord
  belongs_to :book_request
  validates :file, presence: true
  mount_uploader :file, RequestImageUploader

  def url
    file.url
  end

  def thumb_url
    file.thumb_url
  end
end
