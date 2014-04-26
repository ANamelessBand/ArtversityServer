types = [
          'Musician',
          'Artist',
          'Actor',
        ]

types.each do |type|
  Type.create name: type
end
