require "rspec"
require "rack/test"
require "capybara"

require_relative "../controllers/login"

RSpec.describe "Logout Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
    

    describe "POST /login" do
        it "sucsessfull signin with a valid user" do
            visit "/login"
            fill_in "email", with "bp@company.com" #chosen random user from db
            fill_in "password", with "hello"
            click_button "Submit"
            expect(page).to have_content "Login Successful!" #if the sucsess message changes on index.erb, this will fail
            
        end
    end