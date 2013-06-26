class Song
  attr_accessor :artist, :genre, :name

  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  extend Sluggable::ClassMethods
  include Sluggable::InstanceMethods

  extend Listable
  extend Findable

  reset_all

  def url
    "#{self.name}.html"
  end

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

  def to_param
    self.slug
  end

end
