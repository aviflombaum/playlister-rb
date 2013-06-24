require 'pry-debugger'
require 'fileutils'
require 'erb'

require_relative 'environment'

FileUtils.mkdir_p '_site'
FileUtils.mkdir_p '_site/artists'
FileUtils.mkdir_p '_site/genres'
FileUtils.mkdir_p '_site/songs'

parser = LibraryParser.new('/Users/avi/Development/code/playlister-rb/data')
parser.call

class SiteGenerator
  attr_accessor :resource

  def initialize(resource)
    @resource = resource
  end

  def generate_index
    template_content = File.read("views/#{resource}s/#{resource}.erb")
    template = ERB.new(template_content)

    resources = Kernel.const_get(resource.capitalize).all

    case resource
      when 'artists'
        artists = resources
      when 'genres'
        genres = resources
      when 'songs'
        songs = resources
    end

    html = template.result(binding)

    File.open("_site/#{resource}s/#{resource}.html", 'w') { |file| file.write(html) }
  end

  def generate_show
    template_content = File.read("views/#{resource}s/#{resource}.erb")
    template = ERB.new(template_content)

    resources = Kernel.const_get(resource.capitalize).all

    resources.each do |object|
      case resource
        when 'artist'
          artist = object
        when 'genre'
          genre = object
        when 'song'
          song = object
      end

      html = template.result(binding)
      File.open("_site/#{resource}s/#{object.url}", 'w') { |file| file.write(html) }
    end
  end

end

# Building the Index
template_content = File.read('views/index.erb')
template = ERB.new(template_content)
html = template.result
File.open('_site/index.html', 'w') { |file| file.write(html) }

# Building the Artist Index
# template_content = File.read('views/artists/artists.erb')
# template = ERB.new(template_content)

# artists = Artist.all
# html = template.result(binding)

# File.open('_site/artists.html', 'w') { |file| file.write(html) }

# # Build Out the Artist Show
# # read the artist.erb template
# template_content = File.read('views/artist.erb')
# template = ERB.new(template_content)

# artists.each do |artist|
#   html = template.result(binding)
#   File.open("_site/artists/#{artist.url}", 'w') { |file| file.write(html) }
# end
# # create the artist file for each artist

artist_site = SiteGenerator.new('artist')
artist_site.generate_show
artist_site.generate_index

genre_site = SiteGenerator.new('genre')
genre_site.generate_show
genre_site.generate_index

song_site = SiteGenerator.new('song')
song_site.generate_show
song_site.generate_index
