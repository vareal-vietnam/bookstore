class BookRequestImage < ApplicationRecord
  belongs_to :book_request
  validates :url, presence: true
end
