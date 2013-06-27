class PlaylisterApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload './environment'
    also_reload './lib/concerns/memorable.rb'
    also_reload './lib/models/artist.rb'
  end

  get '/' do
    erb :index
  end

  get '/artists' do
    @artists = Artist.all
    erb :'artists/index'
  end

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    erb :'genres/show'
  end

  post '/songs' do
    # {"song_title"=>"SONG NAME", "artist_id"=>"ARTIST ID", "genre"=>"GENRE"}
    song = Song.new_from_params(params)
    redirect "/songs/#{song.to_param}"
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/artists/new' do
    erb :'artists/new'
  end

  get '/simple' do
    erb :simple
  end

  post '/simple' do
    raise params.inspect
  end

  post '/artists' do
    artist = Artist.new

    artist.name = params[:artist_name]
    artist.add_songs(params[:songs])

    redirect "/artists/#{artist.to_param}"
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'artists/show'
  end


end
