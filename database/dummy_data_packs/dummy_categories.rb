categories = [
              [
               'Guitar',
               'Violin',
               'Trumpet',
               'Accordion',
               'Harp',
               'Flute',
               'Onemanband',
              ],
              [
               'Graffitti',
               'Cartoon',
               'Portrait',
              ],
              [
               'Drama',
               'Humor',
               'Dance',
              ],
             ]

categories.each_with_index do |category, index|
  type = Type[index + 1]
  category.each do |subcategory|
    Category.create name: subcategory, type: type
  end
end
