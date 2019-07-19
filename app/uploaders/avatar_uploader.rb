class AvatarUploader < CarrierWave::Uploader::Base
  # process resize_to_fit: [400, 400]
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
