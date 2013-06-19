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
    song.artist = self
    song.genre.artists << self unless song.genre.nil? || song.genre.artists.include?(self)
  end
  def genres
    # @songs.collect { |song| song.genre }.compact.uniq
    Genre.all.select{|genre|genre.artists.include?(self)}
  end
end