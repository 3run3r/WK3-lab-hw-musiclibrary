require('pg')
require_relative('../db/sql_runner')
require_relative('artist')


class Album

attr_reader :id, :artist_id
attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

def save()
  sql = "INSERT INTO albums
  (
    title,
    genre,
    artist_id
    ) VALUES (
      $1, $2, $3
    ) RETURNING id;"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end


def delete()
  sql = "DELETE FROM albums
  WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM albums;"
  results = SqlRunner.run(sql)
  albums = results.map {|album| Album.new(album)}
  return albums
end

def artist()
  sql = "SELECT * FROM artists WHERE id = $1;"
  values = [@artist_id]
  artist_hash = SqlRunner.run(sql, values)[0]
  artist = Artist.new(artist_hash)
  return artist
end

def update()
  sql = "UPDATE albums SET
  ( title,
    genre,
    artist_id ) =
  ( $1, $2, $3 )  WHERE id = $4;"
  values = [@title, @genre, @artist_id, @id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql = "SELECT * FROM albums WHERE id = $1;"
  values = [id]
  results = SqlRunner.run(sql, values)
  return nil if results[0] == nil
  #why is this in here ^?
  album_hash = results[0]
  album = Album.new(album_hash)
  return album
end


end
