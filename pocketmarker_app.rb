require 'sinatra/base'
require 'haml'
require 'pry'

require 'omniauth'
require 'omniauth-pocket'
require 'sinatra/flash'

# recursively require all model files
Dir[Dir.pwd + "/models/**/*.rb"].each { |f| require f }

POCKET_CONSUMER_KEY = YAML.load_file("config/pocket.yaml")["consumer_key"]

class PocketmarkerApp < Sinatra::Base
  configure do
    enable :sessions
    register Sinatra::Flash

    use OmniAuth::Builder do
      provider :pocket, POCKET_CONSUMER_KEY
    end
  end

  helpers do
    def current_user
      !session[:uid].nil?
    end
  end

  before '/upload_bookmarks' do
    #puts session.inspect
    @username = session[:username] if !session[:username].nil?
    
    unless current_user
      flash[:error] = "You need to log in Via Pocket to access this section"
      #redirect to('/') 
    end
  end

  get '/' do
    haml :home
  end

  get '/upload_bookmarks' do
    haml :upload_bookmarks
  end

  post '/upload' do
    bookmark_file = File.read(params[:bookmark_file][:tempfile])
    @bookmark_list = Pocketmarker::BookmarkList.create_from_file(bookmark_file)

    if @bookmark_list.empty?
      flash[:error] = "The file was either corrupted or did not contain any bookmarks"
      redirect to('/upload_bookmarks')
    else
      haml :your_bookmarks
    end
  end

  post "/add_to_pocket" do
    @bookmark_list = Pocketmarker::BookmarkList.new

    params.each do |bookmark_title, bookmark_url|
        @bookmark_list.add(Pocketmarker::Bookmark.new(bookmark_title, bookmark_url))
    end

    pocket_client = PocketAPIClient.new(POCKET_CONSUMER_KEY, session[:access_token])
    
    if pocket_client.add_items(@bookmark_list.bookmarks)
      puts "Success"
      haml :add_to_pocket_success
    else
      puts "Failure"
      haml :add_to_pocket_failure
    end
  end

  get '/auth/pocket/callback' do
    session[:uid] = request.env["omniauth.auth"].uid
    session[:username] = request.env["omniauth.auth"].info.name
    session[:access_token] = request.env["omniauth.auth"].credentials.token
    
    flash[:info] = "You have successfully logged in"
    redirect to('/upload_bookmarks')
  end

  get '/auth/failure' do
  # omniauth redirects to /auth/failure when it encounters a problem
  # so you can implement this as you please
  end
end