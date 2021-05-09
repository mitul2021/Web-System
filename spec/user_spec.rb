require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Index page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "#valid_login?" do
    context "when login details are right" do
      it "returns true" do
          @user = User.new(:username => "username", :password => "12345678", :email => "sample@sheffield.ac.uk")        
          expect(@user.valid_login?).to eq(true)
      end
    end
  end
end