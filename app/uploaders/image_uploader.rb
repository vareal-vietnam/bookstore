class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  process resize_to_fill: [600, 900]

  def size_range
    1..3.megabytes
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [92, 138]
  end
end
