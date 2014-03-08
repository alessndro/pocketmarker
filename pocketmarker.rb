require 'sinatra/base'
require 'haml'
require 'pry'

class Pocketmarker < Sinatra::Base

  before do

  end

  get '/' do

    haml :home
  end

end
