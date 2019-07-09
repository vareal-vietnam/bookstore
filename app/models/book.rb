class Book < ApplicationRecord
  validates :name,  presence: true
  validates :price,  presence: true, default: = 0
  validates :quantity,  presence: true, default: = 0
end
