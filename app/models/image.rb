class Image < ApplicationRecord
  belongs_to :book
  validates :file, presence: true
  mount_uploader :file, ImageUploader
  def url
    file.url
  end
end
