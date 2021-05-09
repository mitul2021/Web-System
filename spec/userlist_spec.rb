require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "User list page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

    it "has user list table" do
      get "/userlist"
      expect(page.has_table?)
    end
        
    it "has a button to suspend user" do
      get "/userlist"
      expect(page.has_button?("Suspend user"))
    end
        
     it "shows the list of admins" do
         visit "/userlist"
         expect(page.has_text?("Below is a list of Admins"))
     end
end