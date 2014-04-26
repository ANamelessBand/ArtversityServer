class Performance < Sequel::Model
  many_to_one :type
  many_to_many :categories

  def validate
    validates_presence [:last_date, :times_tagged, :location_latitude, :location_longitude]
  end
end
