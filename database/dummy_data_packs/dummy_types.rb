types = [
          'musician',
          'artist',
          'actor',
        ]

types.each do |type|
  Type.create name: type
end
