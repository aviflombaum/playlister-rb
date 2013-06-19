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
      song = Song.new.tap{|song|song.name = song_name; song.file_name = file}
      artist = Artist.find_by_name(artist_name) || Artist.new.tap{|artist|artist.name = artist_name}
      genre = Genre.find_by_name(genre_name) || Genre.new.tap{|genre|genre.name = genre_name}
      artist.add_song(song)
      song.genre = genre
    end

  end

end
