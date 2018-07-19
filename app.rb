require 'sinatra/base'
require 'uri'
require 'sinatra/flash'
require './lib/listing'

class BnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
end
  get '/listings' do
    @listings = Listing.all
    erb(:listings)
  end

  get '/listings/new' do
    erb(:listings_new)
  end

  post '/listings/new' do
    Listing.create(params['name'], params['description'], params['price'])
    redirect '/listings'
  end

  get '/users/new' do
    erb(:users_new)
  end

  get '/users/my-listings' do
    @requests_pending = Listing.all_open_requests
    @requests_confirmed = Listing.all_closed_requests
    erb(:users_my_listings)
  end

  post '/users/my-listings' do
    Listing.confirm_booking(params['id'])
    redirect '/users/my-listings'
  end

  post '/listings/:id/request' do
    Listing.request_booking(params['id'])
    redirect '/listings/:id/request'
  end

  get '/listings/:id/request' do
    erb(:users_listing_request_confirmation)
  end
end
