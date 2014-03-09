require 'sinatra/base'
require 'haml'
require 'pry'

require 'omniauth'
require 'omniauth-pocket'

POCKET_CONSUMER_KEY = YAML.load_file("config/pocket.yaml")["consumer_key"]

class Pocketmarker < Sinatra::Base
  configure do
    enable :sessions

    use OmniAuth::Builder do
      provider :pocket, POCKET_CONSUMER_KEY
    end
  end

  before do
    @username = session[:username] if !session[:username].nil?
  end

  get '/' do
    haml :home
  end

  get '/auth/pocket/callback' do
    session[:username] = request.env["omniauth.auth"].info.name
    haml :welcome
  end

  get '/auth/failure' do
  # omniauth redirects to /auth/failure when it encounters a problem
  # so you can implement this as you please
  end
end
