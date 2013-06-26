class PlaylisterApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
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

  get '/genres/:slug' do |slug|
    @genre = Genre.find_by_slug(slug)
    erb :'genres/show'
  end

  get '/songs/:slug' do |slug|
    @song = Song.find_by_slug(slug)
    erb :'songs/show'
  end

  get '/artists/:slug' do |slug|
    @artist = Artist.find_by_slug(slug)
    erb :'artists/show'
  end

end
