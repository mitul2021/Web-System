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
      get "/profilecreate"
        page.has_css?('label', text: "First Name")
    end
    
    it "has a button that says 'Change Profile Details'" do
      get "/profilecreate"
      expect(page.has_button?("Change Profile Details"))
    end
    
    it "contains the profile information'" do
      visit "/profilecreate"
      expect(page.has_text?("Interests:"))
    end

end