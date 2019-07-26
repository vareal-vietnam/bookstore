class BookRequest < ApplicationRecord
  belongs_to :user
  has_many :book_request_images, dependent: :destroy
  accepts_nested_attributes_for :book_request_images, allow_destroy: true
  validates :name, presence: true
  validates :quantity, presence: true,
                       numericality:
                       { only_integer: true, greater_than_or_equal_to: 0 }
  validates :budget, presence: true,
                     numericality:
                      { only_integer: true, greater_than_or_equal_to: 0 }
end
