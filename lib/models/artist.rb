class Artist
  attr_accessor :name, :songs

  extend Memorable::ClassMethods
  extend Findable
  extend Listable

  include Memorable::InstanceMethods

  def self.reset_artists
    reset_all
  end
  reset_artists

  def self.action(index)
    self.all[index-1].list_songs
  end

  def list_songs
    Song.all.each_with_index do |s, index|
      puts "#{index+1}. #{s.name}" if s.genre == self
    end
  end

  def initialize
    super
    @songs = []
  end

  def genres
    songs.collect{|s| s.genre}.flatten.compact.uniq
  end

  def songs_count
    songs.size
  end

  def add_song(song)
    songs << song
    song.artist = self
  end
end
