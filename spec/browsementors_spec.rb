require "rspec"
require "rack/test"

require_relative "../app"

RSpec.describe "Browse mentors page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /browsementors" do
    it "has a status code of 200 (OK)" do
      get "/browsementors"
      expect(last_response.status).to eq(200)
    end

    it "has css" do
      get "/browsementors"
      expect(page.has_css?)
    end

    it "has mentors table" do
        get "/browsementors"
        expect(page.has_table?)
      end
  end
end