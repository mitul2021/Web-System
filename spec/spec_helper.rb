ENV["APP_ENV"] = "testing"

require "simplecov"
SimpleCov.start do
  add_filter "/spec"
end
SimpleCov.coverage_dir "coverage"

require "rspec"

require "rack/test"

require_relative "../app"

require "capybara/rspec"

#session[:env] = "test"

Capybara.app = Sinatra::Application

def app

 Sinatra::Application

end



RSpec.configure do |config|

 config.include Capybara::DSL

 config.include Rack::Test::Methods

end

def clear_database

  DB.from("userrequests").delete
  DB.from("userinterests").delete
  DB.from("requests").delete
  DB.from("pairs").delete
  DB.from("users").delete

end

def add_user(type)
  visit "/register"
  fill_in "username", with: "Test #{type}"
  fill_in "email", with: "#{type}@sheffield.ac.uk"
  fill_in "password", with: "test12345"
  fill_in "password_repeat", with: "test12345"
  choose "#{type}"
  click_button "submit_register"
end

#signs in as the user given in type parameter 
def sign_in(type) #test email is eg: mentee@email.com/mentor@email.com/admin@email.com
  visit "/login"
  fill_in "text", with: "#{type}@sheffield.ac.uk"
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

def fill_profile
  fill_in "first_name", with: "Joe"
  fill_in "surname", with: "Bloggs"
  select "1989", from: "year_of_birth"
  select "Male", from: "gender"
  fill_in "contact_number", with: "07415638951"
  select "Geography", from: "deg_id"
  select "2", from: "deg_year"
  fill_in "major_interest", with: "Cycling"
  fill_in "profile_text", with: "An absolute geezer"
end

def read_profile
  expect(page).to have_field "first_name", text: "Joe" 
end

def recover(type)
  add_user("mentee")
  code = find(class: 'green').text.split(//).last(6).join
  visit "/login"
  click_link "Forgot your credentials?"
  click_link "Change #{type}"
  return code
end

clear_database