require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Mentor List page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /mentorlist" do
    it "has a status code of 302 (OK)" do
      get "/mentorlist"
      expect(last_response.status).to eq(302)
    end

    it "has css" do
      get "/mentorlist"
      expect(page.has_css?("#changedetailsbody"))
    end

    it "has mentors table" do
      get "/mentorlist"
      expect(page.has_table?)
    end
  end
end