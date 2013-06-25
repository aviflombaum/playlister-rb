class PlaylisterApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/artists?.:format?' do
    @artists = Artist.all
    erb :'artists/index'
  end

  get '/songs?.:format?' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/genres?.:format?' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:genre?.:format?' do |genre|
    @genres = Genre.all
    erb :'genres/show'
  end

  get '/songs/:song?.:format?' do |song|
    @song = Song.find(song)
    erb :'songs/show'
  end

  get '/artists/:artist?.:format?' do |artist|
    @artists = Artist.all
    erb :'artists/show'
  end

end
