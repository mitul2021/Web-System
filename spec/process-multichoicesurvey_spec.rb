require "spec_helper"
require_relative "../app"

RSpec.describe "Process MultiChoiceSurvey" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "POST /process-multichoicesurvey" do
    it "being a mentee displays questions for mentee" do
      #may need to use capybara
      #login as a mentee
      #submit multichoicesurvey
      #expect a redirect to login 
      sign_in("mentee")
      visit("/multichoicesurvey")
      fill_in
      
    end
  end
end