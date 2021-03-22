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
    add_user("mentee")
    expect(page).to have_content "You have registered successfully"
    clear_database
  end
  
  it "will not add an already existing user" do
    visit "/register"
    add_user("mentee")
    visit "/register"
    add_user("mentee")
    expect(page).to have_content "there exist user with such email address"
    clear_database
  end
end

describe "the login page" do
  it "will sign in an existing user with correct details" do
    add_user("mentee")
    sign_in("mentee")
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

describe "the home page" do
  it "will show the mentee page if logged in as a mentee" do
    add_user("mentee")
    sign_in("mentee")
    expect(page).to have_content "Welcome, mentee!"
    clear_database
  end
  
  it "will show the mentor page if logged in as a mentor" do
    add_user("mentor")
    sign_in("mentor")
    expect(page).to have_content "Welcome, mentor!"
    clear_database
  end
  
  it "will show the mentor page if logged in as an admin" do
    add_user("admin")
    sign_in("admin")
    expect(page).to have_content "Welcome, admin!"
    clear_database
  end
  
  it "will show if I have no mentor as a mentee" do
    add_user("mentee")
    sign_in("mentee")
    expect(page).to have_content "You don't have a mentor at the moment."
    clear_database
  end
  
  it "will show if I have no mentee as a mentor" do
    add_user("mentor")
    sign_in("mentor")
    expect(page).to have_content "You haven't accepted any mentees yet."
    clear_database
  end
end

describe "the logout page" do
  it "is accessible from the home page" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Logout"
    expect(page).to have_content "Logout was successful"
  end
  
  it "contains link back to login" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Logout"
    click_link "Log in"
    expect(page).to have_content "Login"
  end
end