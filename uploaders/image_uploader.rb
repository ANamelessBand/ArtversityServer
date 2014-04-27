class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "attachments/#{model.performance.id}/#{model.class.to_s.underscore}s/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [nil, 200]
  end
end
