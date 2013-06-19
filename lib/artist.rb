class Artist
  attr_accessor :name, :songs
  All = []

  def initialize
    All << self
    @songs = []
  end

  def genres
    songs.collect{|s| s.genre}.uniq
  end

  def self.reset_artists
    All.clear
  end

  def self.all
    All
  end

  def songs_count
    songs.size
  end

  def self.count
    All.size
  end

  def add_song(song)
    songs << song
    song.artist = self
  end
end
