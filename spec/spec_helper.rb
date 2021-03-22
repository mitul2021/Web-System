require "rspec"

require "rack/test"

require_relative "../app"

require "capybara/rspec"



ENV["APP_ENV"] = "test"



Capybara.app = Sinatra::Application



def app

 Sinatra::Application

end



RSpec.configure do |config|

 config.include Capybara::DSL

 config.include Rack::Test::Methods

end

def clear_database

 DB.from("users").delete

end

def add_test_mentee
  visit "/register"
  fill_in "email", with: "test@email.com"
  fill_in "password", with: "test12345"
  fill_in "password_repeat", with: "test12345"
  choose "mentee"
  click_button "submit_register"
end

def sign_in
  visit "/login"
  fill_in "email", with: "test@email.com"
  fill_in "password", with: "test12345"
  click_button "submit_login"
end

clear_database