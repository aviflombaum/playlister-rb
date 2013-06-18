# require 'pry'
class Artist
  attr_accessor :name, :songs
  @@artists = []
  class << self
    def reset_artists
      @@artists = []
    end
    def count
      @@artists.size
    end
    def all
      @@artists
    end
    def find_by_name(name)
      @@artists.select{|artist|artist.name == name}.first
    end
  end
  def initialize
    @@artists << self
    @songs = []
  end
  def songs_count
    @songs.size
  end
  def add_song(song)
    @songs << song
    song.genre.artists << self unless song.genre.nil? || song.genre.artists.include?(self)
  end
  def genres
    # @songs.collect { |song| song.genre }.compact.uniq
    Genre.all.select{|genre|genre.artists.include?(self)}
  end
end

class Song
  attr_accessor :genre, :name, :artist, :file_name
  @@songs = []
  def self.reset_songs
    @@songs = []
  end
  def initialize
    @@songs << self
  end
  def genre=(genre_obj)
    genre_obj.songs << self
    genre_obj.artists << artist unless artist.nil? || genre_obj.artists.include?(artist)
    @genre = genre_obj
  end
end

class Genre
  attr_accessor :name, :artists, :songs
  @@genres = []
  class << self
    def all
      @@genres
    end
    def reset_genres
      @@genres = []
    end
    def find_by_name(name)
      @@genres.select{|genre|genre.name == name}.first
    end
  end
  def initialize
    @@genres << self
    @songs = []
    @artists = []
  end
end

class Scraper

  require 'find'

  class << self

    def get_files(directory)
      files = []
      Find.find(directory) do |file|
        files << file.split("/").last if file.match(/\.mp3\Z/)
      end
      files
    end

    def generate_object(file)
      regex = file.match(/(.*)\[(.+)\]/).to_a
      artist_name, song_name = regex[1].split(' - ').collect(&:strip)
      genre_name = regex.last
      song = Song.new.tap{|song|song.name = song_name}
      artist = Artist.find_by_name(artist_name) || Artist.new.tap{|artist|artist.name = artist_name}
      genre = Genre.find_by_name(genre_name) || Genre.new.tap{|genre|genre.name = genre_name}
      song.artist = artist
      artist.add_song(song)
      song.genre = genre
    end

  end

end

class Jukebox

  @current_screen = 'welcome'

  def start
    puts welcome_message
  end

  def welcome_message
    "Welcome to the Jukebox.\nBrowse by artist or genre"
  end



  def help
    puts <<-HLP

JUKEBOX HELP

# You may type the following commands:

#   - artist
#       artist will print out a list of available artists, sorted alphabetically.
#       The artist's song count will be d
#   - genre
#       genre will print out a list of available genres.

      HLP
  end

end

directory = 'data'

Scraper.get_files(directory).each{|mp3_file|Scraper.generate_object(mp3_file)}

Jukebox.new.start

