require('pg')
require_relative('../db/sql_runner')
require_relative('album')

class Artist

attr_reader :id
attr_accessor :name

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
  end

def save()
    sql = "INSERT INTO artists
      (
      name
      ) VALUES
      (
      $1
      )  RETURNING id;"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def self.delete_all()
  sql = "DELETE FROM artists"
  SqlRunner.run(sql)
end

def delete()
  sql = "DELETE FROM artists
  WHERE id = $1;"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM artists;"
  results = SqlRunner.run(sql)
  artists = results.map {|artist| Artist.new(artist)}
  return artists
end

def albums()
  sql = "SELECT * FROM albums WHERE artist_id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  albums = results.map {|album| Album.new(album)}
  return albums
end


end
