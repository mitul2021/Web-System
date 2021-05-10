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
end