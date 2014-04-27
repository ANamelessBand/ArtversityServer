class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "attachments/#{model.performance.id}/#{model.class.to_s.underscore}s/#{model.id}"
  end
end
