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

def sign_in(type)
  visit "/login"
  fill_in "email", with: "#{type}@email.com"
  fill_in "password", with: "test12345"
  click_button "submit_login"
end

clear_database