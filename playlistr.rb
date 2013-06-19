# require 'pry'
# require 'active_support/inflector'


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
      @@artists.select{|artist|artist.name.downcase == name.downcase}.first
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
      @@genres.select{|genre|genre.name.downcase == name.downcase}.first
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

module View
  def welcome
    puts "\nWelcome to the Jukebox.\n\nBrowse by artist or genre"
  end
  def artists
    puts "All artists (with song count)"
    Artist.all.sort_by{|a|a.name.downcase}.each do |artist|
      puts "#{artist.name} (#{artist.songs.count})"
    end
    puts "\nTotal Artists: #{Artist.all.count}"
    puts "\nSelect Artist"
  end
  def artist(artist)
    puts "\n#{artist.name} - #{artist.songs.count} Song#{'s' if artist.songs.count != 1}"
    artist.songs.each_with_index do |song, index|
      print "\n#{index+1}: #{song.name}"
      print " - #{song.genre.name}" if song.genre
    end
    puts "\n\nBrowse by artist or genre"
  end
  def genres
    puts "All genres, with song and artist count\n"
    Genre.all.sort_by{|g|g.songs.count}.each do |genre|
      puts "#{genre.name.capitalize}: #{genre.songs.count} Song#{'s' if genre.songs.count != 1}, #{genre.artists.count} Artist#{'s' if genre.artists.count != 1}"
    end
    puts "\nTotal Genres: #{Genre.all.count}"
    puts "\nSelect Genre"
  end
  def genre(genre)
    puts "\nIn #{genre.name.capitalize}:\n"
    genre.songs.each do |song|
      puts "#{song.artist.name} - #{song.name}"
    end
    puts "\n#{genre.name.capitalize} has #{genre.songs.count} song#{'s' if genre.songs.count != 1} and #{genre.artists.count} unique artist#{'s' if genre.artists.count != 1}."
    puts "\n\nBrowse by artist or genre"
  end
  def song(song)
  end

  def exit
    puts "Thank you for using this program!"
  end

end

class Jukebox

  include View

  def start
    @current_screen = 'welcome'
    welcome
    prompt
  end


  def prompt
    print ">>> "
    command = gets.strip
    route(command)
  end

  def route(command)

    return send command if command == 'exit'

    case @current_screen
    when 'welcome'
      case command
      when 'artists', 'genres'
        @current_screen = command
        puts command
        send command
      else
        puts "\n'#{command}' not recognized. Please enter 'artists' or 'genres'"
      end
      prompt
    when 'artists'
      artist = Artist.find_by_name(command)
      if artist
        send('artist', artist)
        @current_screen = 'welcome'
      else
        puts "No Artist with the name '#{command}' Found. Please try again!"
      end
      prompt
    when 'genres'
      genre = Genre.find_by_name(command)
      if genre
        send 'genre', genre
        @current_screen = 'welcome'
      else
        puts "No Genre with the name '#{command}' Found. Please try again!"
      end
      prompt
    end
  end

end

directory = 'data'

Scraper.get_files(directory).each{|mp3_file|Scraper.generate_object(mp3_file)}

Jukebox.new.start

