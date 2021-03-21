require "rspec"
require "rack/test"
require_relative "../app"
require "capybara/rspec"

ENV["APP_ENV"] = "test"

Capybara.app = Sinatra::Application

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
end

