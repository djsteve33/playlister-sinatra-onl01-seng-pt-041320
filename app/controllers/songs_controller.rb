# require 'sinatra/base'
# require 'rack-flash'

# class SongsController < Sinatra::Base
#   enable :sessions
#   use Rack::Flash
#   register Sinatra::ActiveRecordExtension
#   set :session_secret, "my_application_secret"
#   set :views, Proc.new { File.join(root, "../views/") }

#   get '/songs' do
#     @songs = Song.all
#     erb :"songs/index"
#   end

#   get '/songs/new' do
#     #@genres = Genre.all
#     erb :"songs/new"
#   end

 

#   post '/songs' do
#      @song = Song.create(params[:song]) 

#     # artist_entry = params[:song][:artist]
#     # binding.pry
#     # if Artist.find_by(:name => artist_entry)
#     #   artist = Artist.find_by(:name => artist_entry)
#     # else
#     #   artist = Artist.create(:name => artist_entry)
#     # end
#     # @song.artist = artist

#     @song.artist = Artist.find_or_create_by(name: params[:artist][:name]) 

#     # genre_selections = params[:song][:genres]
#     # genre_selections.each do |genre|
#     @song.genre_ids = params[:genres]
#     @song.save

    
#       # @song = Song.create(:name => params["Name"])
#       # @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
#       # @song.genre_ids = params[:genres]
#       # @song.save

#     flash[:message] = "Successfully created song."
#     redirect to "songs/show"

#   end

#  get '/songs/:slug' do 
#   @song = Song.find_by_slug(params[:slug])
#   erb :"songs/show"
#  end
  


#   get '/songs/:slug/edit' do
#     @song = Song.find_by_slug(params[:slug])
  
#     erb :'songs/edit'
#   end
  
#   patch '/songs/:slug' do
#     @song = Song.find_by_slug(params[:slug])
  
#     @song.update(params[:song])
  
#     @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
#     @song.save

#     flash[:message] = "Successfully updated song."
#     redirect to "songs/show"
#    end

# end

  
require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully created song."
    redirect("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end

end