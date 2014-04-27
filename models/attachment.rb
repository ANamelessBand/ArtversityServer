class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [nil, 200]
  end
end

class Attachment < Sequel::Model
  many_to_one :performance

  mount_uploader :filename, ImageUploader

  def validate
    validates_presence [:filename]
  end
end
