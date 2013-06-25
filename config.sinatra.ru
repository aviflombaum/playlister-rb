require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'

require './environment'

parser = LibraryParser.new('/Users/avi/Development/code/playlister-rb/data')
parser.call

require './sinatra_app'

run PlaylisterApp.new
