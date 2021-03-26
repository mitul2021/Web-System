require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Login Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /login" do
    it "has a status code of 200 (OK)" do
      get "/login"
      expect(last_response.status).to eq(200)
    end

    it "says 'Login with your credentials below:'" do
      get "/login"
      expect(last_response.body).to include("Login with your credentials below:")
    end
      
    it "has a button that says 'Create an account'" do
      get "/login"
      expect(page.has_button?("Create an account"))
    end    
        
  end
end