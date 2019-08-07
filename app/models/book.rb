class Book < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  delegate :name, :avatar, :address, :phone, to: :user, prefix: :seller
  validates :name, presence: true
  validates :price, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 0,
                      less_than_or_equal_to: 99_999_000,
                      only_integer: true
                    }
  validates :quantity, presence: true,
                       numericality: {
                         greater_than_or_equal_to: 0,
                         less_than_or_equal_to: 1_000,
                         only_integer: true
                       }
  validates :description, presence: true
end
