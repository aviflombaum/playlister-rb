class Song
  attr_accessor :artist, :genre, :name
  extend Memorable::ClassMethods
  extend Listable

  include Memorable::InstanceMethods

  reset_all

  def self.action(index)
    self.all[index-1].play
  end

  def play
    puts "playing #{self.title}, enjoy!"
  end

  def title
    "#{self.artist.name} - #{self.name} [#{self.genre.name}]"
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end
end
