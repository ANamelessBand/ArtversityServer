tables = [
          'types',
          'categories',
          'performances',
          # 'medias',
         ]

tables.each do |table|
  puts "Populating dummy data into #{table}..."
  require "./database/dummy_data_packs/dummy_#{table}.rb"
  puts "done"
end
