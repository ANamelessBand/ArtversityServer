categories = [
              [
               'guitar',
               'violin',
               'trumpet',
               'accordion',
               'harp',
               'flute',
               'onemanband',
              ],
              [
               'graffitti',
               'cartoon',
               'portrait',
              ],
              [
               'drama',
               'humor',
               'dance',
              ],
             ]

categories.each_with_index do |category, index|
  type = Type[index + 1]
  category.each do |subcategory|
    Category.create name: subcategory, type: type
  end
end
