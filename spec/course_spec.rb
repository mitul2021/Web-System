require "rspec"
require "rack/test"

require_relative "spec_helper"
require_relative "../app"

RSpec.describe "Course.rb" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "#get_deg_name()" do
    context "when method is called" do
      it "returns degree name" do      
          @course = Course.new(:deg_name_functional => "Computer Science")
          expect(@course.get_deg_name()).to eq("Computer Science")
      end
    end 
  end
    
      describe "#get_id()" do
    context "when method is called" do
      it "returns id" do      
          @user = User.new(:username => "username", :password => "12345678", :email => "sample@sheffield.ac.uk", :deg_id => "1")       
          expect(@user.deg_id()).to eq 1
      end
    end 
  end
      describe "#load_id(id)" do
    context "when method is called" do
      it "loads self id" do      
          @course = Course.new(:deg_name_functional => "Computer Science")
          @deg_id = 1
          expect(@course.load_id(@deg_id)).to eq 1
      end
    end 
  end
end