class LibraryParser
  def initialize(dir_name)
    @dir_name = dir_name
  end

  def call
    songs = Dir.entries(@dir_name).delete_if{|str| str[0] == "."}
    songs.each do |filename|
      artist_name = filename.split(" - ")[0]
      song_name = filename.split(" - ")[1].split("[")[0].strip
      genre_name = filename.split(" - ")[1].split(/\[|\]/)[1]

      artist = Artist.find_by_name(artist_name) || Artist.new.tap{|a| a.name = artist_name}

      song = Song.new
      song.name = song_name

      genre = Genre.find_by_name(genre_name) || Genre.new.tap{|g| g.name = genre_name}

      song.genre = genre
      artist.add_song(song)
    end
  end
end

