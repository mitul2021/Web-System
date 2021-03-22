require "rspec"
require "rack/test"

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
      expect(last_response.body).to eq("Logout was successful")
    end
  end
end