class Book < ApplicationRecord
  has_many :images
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
