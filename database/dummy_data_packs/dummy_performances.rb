fmi_latitude = 42.6736676
fmi_longitude = 23.3303228

latitudes = [
             42.6736676,
             42.6722676,
             42.6743676,
             42.6759676,
             42.6710676,
             42.6746676,
            ]

longitudes = [
              23.3373228,
              23.3239228,
              23.3285228,
              23.3281228,
              23.3343228,
              23.3381228,
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
  is_band = index % 4 == 0

  performance = Performance.create last_seen: last_seen[index],
                                   times_tagged: times_tagged[index],
                                   location_latitude: latitude,
                                   location_longitude: longitudes[index],
                                   type: type,
                                   is_band: is_band

  selected_categories.each do |category|
    performance.add_category category
  end
end
