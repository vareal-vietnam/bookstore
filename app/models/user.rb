class User < ApplicationRecord
  VALID_PHONE_REGEX = /\A[0]\d{9}\z/i.freeze

  has_many :books, dependent: :destroy

  has_many :book_requests, dependent: :destroy

  has_secure_password

  validates :name, presence: true, length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :phone, presence: true,
                    length: { is: 10 },
                    format: { with: VALID_PHONE_REGEX },
                    uniqueness: { case_sensitive: false }

  mount_uploader :avatar, AvatarUploader
end
