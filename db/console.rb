require('pry')

require_relative('../models/artist')
require_relative('../models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Radiohead'
  })

artist1.save()

artist2 = Artist.new({
  'name' => 'Fleetwood Mac'
  })

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Ok Computer',
  'genre' => 'alternative rock'
  })
album1.save()

album2 = Album.new({
    'artist_id' => artist1.id,
    'title' => 'Kid A',
    'genre' => 'alternative rock'
})
album2.save()

album3 = Album.new({
    'artist_id' => artist1.id,
    'title' => 'Amnesiac',
    'genre' => 'alternative rock'
})
album3.save()

binding.pry
nil
