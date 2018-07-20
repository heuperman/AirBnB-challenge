require 'sinatra/base'
require 'uri'
require 'sinatra/flash'
require './lib/listing'
require './lib/user'

class BnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  post '/sessions/new' do
    user = User.authenticate(params['email'], params['password'])
    if user
      session[:user_id] = user.id
      redirect '/listings'
    else
      flash[:notice] = 'invalid email or password'
      redirect('/')
    end
  end

  get '/listings' do
    @user_id = session[:user_id]
    @listings = Listing.all
    erb(:listings)
  end

  get '/listings/new' do
    erb(:listings_new)
  end

  post '/listings/new' do
    Listing.create(params['name'], params['description'], params['price'], session[:user_id])
    redirect '/listings'
  end

  get '/users/new' do
    erb(:users_new)
  end

  post '/users/new' do
    user = User.create(params['user_name'], params['user_email'], params['user_password'])
    session[:user_id] = user.id
    redirect '/listings'
  end

  get '/users/:id/requests' do
    user_id = session[:user_id]
    @requests_pending = Listing.all_open_requests(user_id)
    @requests_confirmed = Listing.all_closed_requests(user_id)
    erb(:users_my_listings)
  end

  post '/users/my-listings' do
    Listing.confirm_booking(params['id'])
    user_id = session[:user_id]
    redirect "/users/#{user_id}/requests"
  end

  post '/listings/:id/request' do
    Listing.request_booking(params['id'])
    redirect '/listings/:id/request'
  end

  get '/listings/:id/request' do
    erb(:users_listing_request_confirmation)
  end
end
