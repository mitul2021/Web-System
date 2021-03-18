require "rspec"
require "rack/test"

require_relative "../controllers/process-multichoicesurvey"

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
      
    end
  end
end