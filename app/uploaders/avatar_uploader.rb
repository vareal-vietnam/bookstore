class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  process resize_to_fill: [600, 600]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.image_path('BookLogo.jpg')
  end
end
