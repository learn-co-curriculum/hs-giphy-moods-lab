require './config/environment'
require './app/models/giph.rb'
require './app/models/mood.rb'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
      enable :sessions
    set :session_secret, 'fwitter'
  end

  get '/' do
    erb :index
  end

  post '/results' do
    gipher = Giph.new
    @photo_urls = gipher.search(params[:mood])
    @mood = params[:mood]
    erb :results
  end

  post '/save' do
    Mood.create(:mood => params[:mood], :image_url => params[:url])
    redirect('/moods')
  end

  get '/moods' do
    @moods = Mood.all
    erb :moods
  end

  post '/destroy' do
    Mood.destroy(params[:mood_id])
    redirect('/')
  end
end
