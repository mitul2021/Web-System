require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Browse mentors page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /browsementors" do
    it "has a status code of 302 (OK)" do
      get "/browsementors"
      expect(last_response.status).to eq(302)
    end

    it "has css" do
      get "/browsementors"
      expect(page).to have_css
    end

    it "has mentors table" do
      get "/browsementors"
      expect(page.has_table?)
    end
  end
end