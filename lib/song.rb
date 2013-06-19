class Song

  attr_accessor :genre, :name, :artist, :file_name

  def genre=(genre_obj)
    genre_obj.songs << self
    genre_obj.artists << artist unless artist.nil? || genre_obj.artists.include?(artist)
    @genre = genre_obj
  end

end