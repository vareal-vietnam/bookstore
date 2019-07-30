class BookRequestImage < ApplicationRecord
  belongs_to :book_request
  validates :file, presence: true
  mount_uploader :file, RequestImageUploader
end
