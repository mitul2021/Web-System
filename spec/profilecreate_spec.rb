require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Profilecreate.rb" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "#load_userinterest(params, user_id, i)" do
    context "when user interest is not valid" do
      it "returns false" do
          @user = User.new(:username => "username", :password => "12345678", :email => "sample@sheffield.ac.uk")  
          @userinterest = Userinterest.new
          expect(@userinterest.valid?).to eq(false)
      end
    end
  end
        context "when user interest is valid" do
      it "returns true" do
          @user = User.new(:username => "username", :password => "12345678", :email => "sample@sheffield.ac.uk")  
          @userinterest = Userinterest.new
           @userinterest.user_id = 1
          @userinterest.interest_id = 2
          expect(@userinterest.valid?).to eq(true)
      end
    end
end