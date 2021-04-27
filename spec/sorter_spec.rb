require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"
require_relative "../helpers/sorter"

RSpec.describe "Login Page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  describe "sort" do
      @mentors = User.where(user_type: "mentor")
  end
    
    
#@user = User[id_num]