require "rspec"
require "rack/test"

require_relative "../controllers/browsementors"

RSpec.describe "Browse mentors page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /browsementors" do
    it "has a status code of 200 (OK)" do
      get "/logout"
      expect(last_response.status).to eq(200)
    end

    it "has css" do
      get "/logout"
      expect(page.has_css?)
    end

    it "has mentors table" do
        get "/logout"
        expect(page.has_table?)
      end
  end
end