class Song
  attr_accessor :artist, :genre

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end
end
