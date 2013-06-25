require "bundler/setup"
require "sinatra/base"
require "sinatra/reloader"

require './environment'

require './sinatra_app'

run PlaylisterApp.new
