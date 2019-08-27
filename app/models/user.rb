class User < ApplicationRecord
  attr_accessor :remember_token

  before_validation :strip_whitespace

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

  def generate_digest(string)
    user_digest =
      BCrypt::Password.create(string, cost: BCrypt::Engine::DEFAULT_COST)
    user_digest.split('.').join
  end

  def generate_user_new_token
    SecureRandom.urlsafe_base64
  end

  def generate_remember_token!
    self.remember_token = generate_user_new_token
    update_attribute(:remember_digest, generate_digest(remember_token))
  end

  def authenticated?(token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def remove_remember_digest
    update_attribute(:remember_digest, nil)
  end

  def strip_whitespace
    self.name = name.strip unless name.nil?
    self.address = address.strip unless address.nil?
  end

  def send_password_reset(phone, email)
    digest_value = generate_digest(password_reset_token)
    update_attribute(:password_reset_token, digest_value)
    update_attribute(:password_reset_sent_at, Time.zone.now)
    UserMailer.password_reset(phone, email).deliver
  end

  def password_reset_expired?
    Time.zone.now - password_reset_sent_at < 2.hours
  end
end
