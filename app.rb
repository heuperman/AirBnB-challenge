require 'sinatra/base'
require 'uri'
require 'sinatra/flash'

class BnB < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

end
