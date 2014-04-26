fmi_latitude = 42.6736676
fmi_longitude = 23.3303228

latitudes = [
             42.6736676,
             42.6732676,
             42.6743676,
             42.6730676,
             42.6749676,
             42.6738676,
            ]

longitudes = [
              23.3303228,
              23.3309228,
              23.3305228,
              23.3311228,
              23.3313228,
              23.3301228,
             ]

time_now = DateTime.now

last_seen = [
              time_now - 0.02,
              time_now - 0.04,
              time_now - 0.08,
              time_now - 0.01,
              time_now - 0.11,
              time_now - 0.05,
             ]

times_tagged = [
                7,
                1,
                3,
                8,
                1,
                2,
               ]

latitudes.each_with_index do |latitude, index|
  type_id = index % 3
  type = Type[type_id + 1]

  categories = type.categories
  categories_count = times_tagged[index] % 3 + 1
  selected_categories = categories.take categories_count

  performance = Performance.create last_seen: last_seen[index],
                                   times_tagged: times_tagged[index],
                                   location_latitude: latitude,
                                   location_longitude: longitudes[index],
                                   type: type

  selected_categories.each do |category|
    performance.add_category category
  end
end
