require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "User.rb" do
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
      
    context "when password is empty" do
      it "returns false" do
          @user = User.new(:username => "username", :password => "", :email => "sample@sheffield.ac.uk")        
          expect(@user.valid_login?).to eq(false)
      end
    end
      
    context "when no details are entered" do
      it "returns false" do
          @user = User.new(:username => "", :password => "", :email => "")        
          expect(@user.valid_login?).to eq(false)
      end
    end
      
    context "when email is entered but not username" do
      it "returns false" do
          @user = User.new(:username => "", :password => "", :email => "sample@sheffield.ac.uk")        
          expect(@user.valid_login?).to eq(false)
      end
    end
    
    context "when username is entered but not email" do
      it "returns false" do
          @user = User.new(:username => "23575324", :password => "", :email => "")        
          expect(@user.valid_login?).to eq(false)
      end
    end
  end
    
      describe "#approved_email?" do
    context "when the email is not approved" do
      it "returns false" do
          @user = User.new(:username => "23575324", :password => "", :email => "notapproved@no.com")        
          expect(@user.approved_email?).to eq(false)
      end
    end

    context "when the email is approved" do
      it "returns true" do
          @user = User.new(:username => "23575324", :password => "", :email => "approved@sheffield.ac.uk")        
          expect(@user.approved_email?).to eq(true)
      end
    end
end

      describe "#valid_details?" do
    context "when the details are valid" do
      it "returns true" do
          @user = User.new(:username => "username", :password => "12345678", :email => "approved@sheffield.ac.uk")        
          expect(@user.valid_details?).to eq(true)
      end
    end
end
end