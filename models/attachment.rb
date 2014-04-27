class Attachment < Sequel::Model
  many_to_one :performance

  mount_uploader :filename, ImageUploader

  def validate
    validates_presence [:filename]
  end
end
