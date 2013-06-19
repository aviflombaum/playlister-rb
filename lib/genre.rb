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