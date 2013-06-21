require 'pry-debugger'

require_relative 'environment'

class CLIPlaylisterApp
  def run
    parser = LibraryParser.new('/Users/avi/Development/code/playlister-rb/data')
    parser.call

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

      # binding.pry
    end

    puts "Goodbye!"
  end
end
