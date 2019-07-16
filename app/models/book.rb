class Book < ApplicationRecord
  has_many :images, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
