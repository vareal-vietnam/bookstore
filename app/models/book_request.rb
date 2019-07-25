class BookRequest < ApplicationRecord
  belongs_to :user
  has_many :book_request_image, dependent: :destroy
  validates :name, presence: true
  validates :quantity, presence: true, numericality: { other_than: 0 }
end
