require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Profile Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

    it "has css" do
      get "/profile"
        page.has_css?('H3', text: "Contact Details:")
    end
    
    it "has a button return to previous page" do
      get "/profile"
      expect(page.has_button?("Go back"))
    end
    
        it "has the user's first name" do
      get "/profile"
        page.has_css?('H1', text: " ")
    end

end