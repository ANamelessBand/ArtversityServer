class Performance < Sequel::Model
  many_to_one :type
  many_to_many :categories
  one_to_many :medias

  def validate
    validates_presence [:last_seen, :times_tagged, :location_latitude, :location_longitude]
  end

  def before_save
    puts "FUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUCK"
    tag
    super
  end

  def full_data
    core_data.merge media_data
  end

  def media_data
    # TODO: Think about this represation
    {
      pictures: [],
      videos: [],
      audios: []
    }
  end

  def core_data
    {
      id: id,
      rating: 42,
      location: {
        latitude: location_latitude,
        longitude: location_longitude
      },
      times_tagged: times_tagged,
      type: type.name,
      categories: categories.map(&:name),
      picture: 'pictures.last.url'
    }
  end

  def tag
    self.last_seen = DateTime.now
    self.times_tagged = times_tagged.to_i + 1 # TODO: WRITE MIGRATION: times_tagged to be 0 by default
  end
end
