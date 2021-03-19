require "rspec"
require "rack/test"

require_relative "../controllers/index.rb"

RSpec.describe "Index page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /index" do
    it "has a status code of 200 (OK)" do
      get "/index"
      expect(last_response.status).to eq(200)
    end

    it "has css" do
      get "/index"
      expect(page.has_css?)
    end

    it "displays the text 'welcome'" do
        get "/index"
        expect(page).to have_text("Welcome")
      end
  end
end