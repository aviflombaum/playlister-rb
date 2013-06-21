module WebApp
  class Main
    def call(env)
    end
  end

  class Index
    def initialize(app)
      @app = app
    end

    def call(env)
      template = ERB.new(File.read('views/index.erb'))

      b = binding
      html = template.result(b)
      # define my erb template
      # generate my ERB template with all the artists
      # and send back as the content

      [200, {'Content-Type' => 'text/html'}, [html]]
    end
  end

  class Artists
    def initialize(app)
      @app = app
    end

    def call(env)
      artists = Artist.all
      template = ERB.new(File.read('views/artists.erb'))

      b = binding
      html = template.result(b)
      # define my erb template
      # generate my ERB template with all the artists
      # and send back as the content

      [200, {'Content-Type' => 'text/html'}, [html]]
    end
  end

  class Songs
    def initialize(app)
      @app = app
    end

    def call(env)
    end
  end

  class Genres
    def initialize(app)
      @app = app
    end

    def call(env)
    end
  end

end

