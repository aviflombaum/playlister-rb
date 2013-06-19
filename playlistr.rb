require_relative 'lib/artist'
require_relative 'lib/song'
require_relative 'lib/genre'
require_relative 'lib/scraper'
require_relative 'lib/view'

class Jukebox

  include View

  def start
    @current_screen = 'welcome'
    welcome
    prompt
  end


  def prompt
    print ">>> "
    command = gets.strip
    route(command)
  end

  def route(command)

    return send command if command == 'exit'

    case @current_screen
    when 'welcome'
      case command
      when 'artists', 'genres'
        @current_screen = command
        send command
      else
        puts "\n'#{command}' not recognized. Please enter 'artists' or 'genres'"
      end
      prompt
    when 'artists', 'genres'
      obj_name = @current_screen[0..-2]
      obj = Object.const_get(obj_name.capitalize).find_by_name(command)
      if obj
        send obj_name, obj
        @current_screen = 'welcome'
      else
        puts "No #{obj_name} with the name '#{command}' Found. Please try again!"
      end
      prompt
    end
  end

end

directory = 'data'

Scraper.get_files(directory).each{|mp3_file|Scraper.generate_object(mp3_file)}

Jukebox.new.start

