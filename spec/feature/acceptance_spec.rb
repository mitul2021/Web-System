require_relative "../spec_helper"

describe "the register page" do
  it "is accessible from the login page" do
    visit "/login"
    click_link "Create an account"
    expect(page).to have_content "Register"
  end
  
  it "will not add a user with no details" do
    visit "/register"
    click_button "submit_register"
    expect(page).to have_content "email cannot be empty"
  end
  
  it "will not add a user with no password" do
    visit "/register"
    fill_in "email", with: "test@email.com"
    click_button "submit_register"
    expect(page).to have_content "password cannot be empty"
  end
  
  it "will not add a user without matching passwords" do
    visit "/register"
    fill_in "email", with: "test@email.com"
    fill_in "password", with: "test1234"
    fill_in "password_repeat", with: "test12345"
    click_button "submit_register"
    expect(page).to have_content "not the same"
  end
  
  it "will not add a user with short password (less than 8 characters)" do
    visit "/register"
    fill_in "email", with: "test@email.com"
    fill_in "password", with: "test1"
    fill_in "password_repeat", with: "test1"
    click_button "submit_register"
    expect(page).to have_content "must be at least"
  end
  
  it "will add a user when all details are entered" do
    visit "/register"
    add_test_mentee
    save_page
    expect(page).to have_content "You have registered successfully"
    clear_database
  end
  
  it "will not add an already existing user" do
    visit "/register"
    add_test_mentee
    visit "/register"
    add_test_mentee
    expect(page).to have_content "there exist user with such email address"
    clear_database
  end
end

describe "the login page" do
  it "will sign in an existing user with correct details" do
    add_test_mentee
    sign_in
    expect(page).to have_content "Login successful"
    clear_database
  end
  
  it "will not login a user with no details" do
    visit "/login"
    click_button "submit_login"
    expect(page).to have_content "does not match"
  end
  
  it "will not login a user with incorrect details" do
    visit "/login"
    fill_in "email", with: "bad@email.com"
    fill_in "password", with: "badd1234"
    click_button "submit_login"
    expect(page).to have_content "does not match"
  end
end

describe "the mentee page" do
  
end