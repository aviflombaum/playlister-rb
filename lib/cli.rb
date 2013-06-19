require 'pry'

require_relative 'memorable'
require_relative 'findable'
require_relative 'listable'

require_relative 'artist'
require_relative 'song'
require_relative 'genre'
require_relative 'parser'

parse_directory('/Users/avi/Development/code/playlister-rb/data')

puts "Welcome to the playlist!!!"
puts "Please enter a command:"

command = ""

while command != 'exit'
  command = gets.downcase.strip

  case command
  when 'help'
    puts "I respond to: "
    puts "browse <type> - browse aritsts, genres, songs"
  when /(genre|artist|song) \d+/
    type = command.split.first.strip.downcase
    index = command.split.last.strip.downcase.to_i
    Kernel.const_get(type.capitalize).action(index) if ["song", "artist", "genre"].include?(type)
  when /browse/
    type = command.split.last.strip.downcase[0..-2]
    Kernel.const_get(type.capitalize).list if ["song", "artist", "genre"].include?(type)
  end
end

puts "Goodbye!"
