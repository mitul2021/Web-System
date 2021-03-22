require "simplecov"
SimpleCov.start do
  add_filter "/spec"
end
SimpleCov.coverage_dir "coverage"

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

def add_user(type)
  visit "/register"
  fill_in "email", with: "#{type}@email.com"
  fill_in "password", with: "test12345"
  fill_in "password_repeat", with: "test12345"
  choose "#{type}"
  click_button "submit_register"
end

#signs in as the user given in type parameter 
def sign_in(type) #test email is eg: mentee@email.com/mentor@email.com/admin@email.com
  visit "/login"
  fill_in "email", with: "#{type}@email.com"
  fill_in "password", with: "test12345"
  click_button "submit_login"
end

def add_mentor_mentee
  add_user("mentor")
  sign_in("mentor")
  click_link "Logout"
  visit "/login"
  add_user("mentee")
  sign_in("mentee")
end

clear_database