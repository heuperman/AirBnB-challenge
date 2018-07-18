require 'sinatra/base'
require 'uri'
require 'sinatra/flash'

class BnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/listings' do
    erb(:listings)
  end

  get '/listings/new' do
    erb(:listings_new)
  end
end
