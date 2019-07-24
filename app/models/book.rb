class Book < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  delegate :name, :avatar, :address, :phone, to: :user, prefix: :seller
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0,  only_integer: true }
  validates :description, presence: true
end
