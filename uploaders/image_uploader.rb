class ImageUploader < FileUploader
  include CarrierWave::MiniMagick

  version :thumb do
    process resize_to_fit: [nil, 200]
  end

  version :large do
    process resize_to_fit: [nil, 720]
  end
end
