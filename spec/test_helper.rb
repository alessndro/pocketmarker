ENV['RACK_ENV'] = 'test'

require_relative '../pocketmarker.rb'
require 'rack/test'
require 'rspec'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app() Pocketmarker end

  Capybara.app = app
end
