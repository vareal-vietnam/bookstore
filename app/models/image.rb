class Image < ApplicationRecord
  belongs_to :book
  validates :url, presence: true
end
