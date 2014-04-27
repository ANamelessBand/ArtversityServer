class Performance < Sequel::Model
  many_to_one :type
  many_to_many :categories
  one_to_many :attachments

  def validate
    validates_presence [:last_seen, :times_tagged, :location_latitude, :location_longitude]
  end

  def full_data
    core_data.merge media_data
  end

  def active
    DateTime.parse(last_seen.to_s) > DateTime.now.prev_day
  end

  def media_data
    # TODO: Think about this represation
    {
      pictures: pictures.map { |picture| pic_regex_magic picture },
      videos: videos.map { |video| regex_magic2 video },
      audios: audios.map { |audio| regex_magic2 audio }
    }
  end

  def regex_magic2(attachment)
    file = attachment.filename.file.file
    store_dir = attachment.filename.store_dir

    { filename: file[Regexp.new(store_dir + '.*')] }
  end

  def pic_regex_magic(pic)
    thumb = pic.filename.thumb.file.file
    large = pic.filename.large.file.file
    pic_store_dir = pic.filename.store_dir

    thumb_url = thumb[Regexp.new(pic_store_dir + '.*')]
    large_url = large[Regexp.new(pic_store_dir + '.*')]

    { large: large_url, thumb: thumb_url }
  end

  def core_data
    values[:active] = active
    pics = pictures
    if pics.empty?
      values[:picture] = 'default.jpg'
    else
      values[:picture] = pic_regex_magic(pics.last)[:thumb]
    end

    values.merge(type_data).merge categories_data
  end

  def type_data
    {type: type.values}
  end

  def categories_data
    {categories: categories.map(&:values)}
  end

  def tag
    self.last_seen = DateTime.now
    # TODO: WRITE MIGRATION: times_tagged to be 0 by default
    self.times_tagged = (times_tagged || 0) + 1
  end

  def in_latitude_range?(other_latitude, range)
    latitude_difference = location_latitude - other_latitude
    latitude_difference.abs < range
  end

  def in_longitude_range?(other_longitude, range)
    longitude_difference = location_longitude - other_longitude
    longitude_difference.abs < range
  end

  def nearby?(other_latitude, other_longitude, range)
    in_latitude_range?(other_latitude, range) &&
      in_longitude_range?(other_longitude, range)
  end

  def attachment_with_type(type)
    attachments.select { |attachment| attachment.type == type }
  end

  def pictures
    attachment_with_type 'Picture'
  end

  def videos
    attachment_with_type 'Video'
  end

  def audios
    attachment_with_type 'Audio'
  end

  class << self
    def core_data
      all.map &:core_data
    end

    def full_data
      all.map &:full_data
    end

    def nearby_from_dataset(dataset, other_latitude, other_longitude, range)
      dataset.all.select do |performance|
        performance.nearby?(other_latitude, other_longitude, range)
      end
    end

    def nearby(other_latitude, other_longitude, range)
      dataset = self
      nearby_from_dataset(dataset, other_latitude, other_longitude, range)
    end

    def recent(other_latitude, other_longitude, range)
      dataset = reverse_order :last_seen
      nearby_from_dataset(dataset, other_latitude, other_longitude, range)
    end
  end
end
