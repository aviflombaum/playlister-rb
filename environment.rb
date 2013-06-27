# require_relative 'lib/concerns/memorable'
# require_relative 'lib/concerns/findable'
# require_relative 'lib/concerns/listable'

# require_relative 'lib/models/artist'
# require_relative 'lib/models/song'
# require_relative 'lib/models/genre'
# require_relative 'lib/models/library_parser'

# Dir.glob('./lib/concerns/*.rb').each do |concern|
#   require concern
# end

# Dir.glob('./lib/models/*.rb').each do |model|
#   require model
# end

Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    # puts file
    require file
  end
end

