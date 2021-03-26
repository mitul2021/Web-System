require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Logout Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /logout" do
    it "has a status code of 200 (OK)" do
      get "/logout"
      expect(last_response.status).to eq(200)
    end

    it "says 'Logout was successful'" do
      get "/logout"
      expect(last_response.body).to include("Logout was successful")
    end
      
    it "has a button that says 'Log in'" do
      get "/logout"
      expect(page.has_button?("Log in"))
    end  
      
  end
end