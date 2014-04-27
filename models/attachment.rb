class Attachment < Sequel::Model
  plugin :single_table_inheritance, :type

  many_to_one :performance

  def validate
    validates_presence [:filename]
  end
end

class Picture < Attachment
  mount_uploader :filename, ImageUploader
end

class Audio < Attachment
  mount_uploader :filename, FileUploader
end

class Video < Attachment
  mount_uploader :filename, FileUploader
end
