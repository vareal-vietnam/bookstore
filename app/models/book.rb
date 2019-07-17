class Book < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
end
