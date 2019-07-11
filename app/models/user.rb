class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true, length: { maximum: 20 }
	validates :address, presence: true, length: { maximum: 50 }
	validates :password, presence: true, length: {minimum: 6}
	VALID_PHONE_REGEX = /\A[0]\d{9}\z/i  
	validates :phone, presence: true,
                    format: { with: VALID_PHONE_REGEX }
    #mount_uploader :avatar, PictureUploader


end
