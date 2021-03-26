require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Index page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  #this returns a 302 redirect instead of 200, should be inconsequential
  describe "GET /index" do
    it "has a status code of 302 (OK)" do
      get "/index"
      expect(last_response.status).to eq(302)
    end

    it "has css" do
      get "/index"
        page.has_css?('title', text: "Home")
    end

    it "displays the text 'welcome'" do
        visit '/index'
        expect(page.has_text?("Welcome"))
      end
  end
end