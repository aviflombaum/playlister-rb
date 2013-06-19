module View

  def welcome
    puts "\nWelcome to the Jukebox.\n\nBrowse by artist or genre"
  end

  def artists
    puts "All artists (with song count)"
    Artist.all.sort_by{|a|a.name.downcase}.each do |artist|
      puts "#{artist.name} (#{artist.songs_count})"
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