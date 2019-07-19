class Book < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  delegate :name, :avatar, :address, :phone, to: :user, prefix: 'seller'
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
end
