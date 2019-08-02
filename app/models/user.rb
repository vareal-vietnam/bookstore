class User < ApplicationRecord
  attr_accessor :remember_token

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

  def user_digest(string)
    BCrypt::Password.create(string, cost: BCrypt::Engine::DEFAULT_COST)
  end

  def user_new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = user_new_token
    update_attribute(:remember_digest, user_digest('remember_token'))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
