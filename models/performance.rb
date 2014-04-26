class Performance < Sequel::Model
  many_to_one :type
  many_to_many :categories
  one_to_many :medias

  def validate
    validates_presence [:last_seen, :times_tagged, :location_latitude, :location_longitude]
  end
end
