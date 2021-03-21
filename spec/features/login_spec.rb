require_relative "../spec_helper"


describe "POST /login" do
    it "sucsessfull signin with a valid user" do
        visit "/login"
        fill_in "email", with: "bp@company.com" #chosen random user from db
        fill_in "password", with: "hello"
        click_button "submit_login"
        expect(page).to have_content "Login successful" #if the sucsess message changes on index.erb, this will fail
            
    end
end
