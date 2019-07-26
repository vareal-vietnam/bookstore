class BookRequestImage < ApplicationRecord
  belongs_to :book_request
  validates :url, presence: true
  mount_uploader :url, RequestImageUploader
end
