class BookRequest < ApplicationRecord
  belongs_to :user
  has_many :book_request_image, dependent: :destroy
  validates :name, presence: true
  validates :quantity, presence: true,
                       numericality:
                       { only_integer: true, greater_than_or_equal_to: 0 }
  validates :budget, presence: true,
                     numericality: { only_integer: true, greater_than: 0 }
end
