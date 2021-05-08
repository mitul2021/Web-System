require_relative "../spec_helper"

describe "the register page" do
  it "is accessible from the login page" do
    visit "/login"
    click_link "Create an account"
    expect(page).to have_content "Register"
    clear_database
  end
  
  it "will not add a user with no details" do
    visit "/register"
    click_button "submit_register"
    expect(page).to have_content "email cannot be empty"
    clear_database
  end
  
  it "will not add a user with no password" do
    visit "/register"
    fill_in "email", with: "test@sheffield.ac.uk"
    click_button "submit_register"
    expect(page).to have_content "password cannot be empty"
    clear_database
  end
  
  it "will not add a user without matching passwords" do
    visit "/register"
    fill_in "email", with: "test@sheffield.ac.uk"
    fill_in "password", with: "test1234"
    fill_in "password_repeat", with: "test12345"
    click_button "submit_register"
    expect(page).to have_content "not the same"
    clear_database
  end
  
  it "will not add a user with short password (less than 8 characters)" do
    visit "/register"
    fill_in "email", with: "test@sheffield.ac.uk"
    fill_in "password", with: "test1"
    fill_in "password_repeat", with: "test1"
    click_button "submit_register"
    expect(page).to have_content "must be at least"
    clear_database
  end
  
  it "requires the the user to add a username" do
    visit "/register"
    fill_in "email", with: "test@sheffield.ac.uk"
    fill_in "password", with: "test1234"
    fill_in "password_repeat", with: "test1234"
    click_button "submit_register"
    expect(page).to have_content "username cannot be empty"
    clear_database
  end
  
  it "will not add a user without an approved university email address" do
    visit "/register"
    fill_in "username", with: "Test"
    fill_in "email", with: "test@invalid.com"
    fill_in "password", with: "test1234"
    fill_in "password_repeat", with: "test1234"
    click_button "submit_register"
    expect(page).to have_content "this email address is of not approved university"
    clear_database
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
    expect(page).to have_content "Your Email or Username cannot be empty"
    clear_database
  end
  
  it "will not login a user with incorrect details" do
    visit "/login"
    fill_in "text", with: "bad@sheffield.ac.uk"
    fill_in "password", with: "badd1234"
    click_button "submit_login"
    expect(page).to have_content "does not match"
    clear_database
  end
  
  it "will login a user with their username" do
    add_user("mentee")
    visit "/login"
    fill_in "text", with: "Test mentee"
    fill_in "password", with: "test12345"
    click_button "submit_login"
    save_page
    expect(page).to have_content "Login successful"
    clear_database
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
    expect(page).to have_content "You don't have any relationships at the moment."
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
    clear_database
  end
  
  it "contains link back to login" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Logout"
    click_link "Log in"
    expect(page).to have_content "Login"
    clear_database
  end
end

describe "the profile page" do
  it "is accessible from the home page" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    expect(page).to have_content "Your Profile"
    clear_database
  end
  
  it "contains fields for changing personal info" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    expect(page).to have_content "First Name:"
    clear_database
  end
  
  it "contains fields for changing mentee information" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    expect(page).to have_content "Degree year:"
    clear_database
  end
  
  it "contains fields for changing mentor information" do
    add_user("mentor")
    sign_in("mentor")
    click_link "Profile"
    expect(page).to have_content "Job title:"
    clear_database
  end
end

describe "the mentor list page" do
  it "is accessible from the mentee page" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Mentor List"
    expect(page).to have_content "Mentors"
    clear_database
  end
  
  it "is accessible from the admin page" do
    add_user("admin")
    sign_in("admin")
    click_link "User List"
    expect(page).to have_content "enrolled in the system"
    clear_database
  end
  
  it "contains list of available mentors" do
    add_mentor_mentee
    visit "/mentorlist"
    expect(page).to have_content "Mentors"
    clear_database
  end
end

describe "mentor-mentee pairing" do
  it "allows a mentee request a mentor" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    clear_database
  end
  
  it "shows a requested mentor on the home page" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    visit "/index"
    expect(page.has_link?("Cancel request"))
    clear_database
  end
  
  it "allows a mentee to cancel a request " do
    add_mentor_mentee
    visit "/mentorlist"
    find('input[name="cancel_meeting_request"]').click
    puts "test"
    expect(page).to have_content "You have successfully requested a meeting with the mentor. Wait for the mentor to accept or decline your request."
    clear_database
  end
  
  it "shows mentors requested mentees" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    expect(page).to have_content "Accept Request"
    clear_database
  end
  
  it "allows mentors to decline mentees" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    click_link "Decline Request"
    expect(page).to have_content "You haven't recieved any new mentorship requests yet."
    clear_database
  end
  
  it "allows mentors to accept mentees" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    click_link "Accept Request"
    expect(page).to have_content "Cancel Mentorship"
    clear_database
  end
  
  it "allows mentors to cancel a mentorship" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    click_link "Accept Request"
    click_link "Cancel Mentorship"
    expect(page).to have_content "You haven't accepted any mentees yet."
    clear_database
  end
  
  it "shows mentees their mentor" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    click_link "Accept Request"
    sign_in("mentee")
    expect(page).to have_content "Cancel Mentorship"
    clear_database
  end
  
  it "allows mentees to cancel their mentorship" do
    add_mentor_mentee
    visit "/mentorlist"
    click_button "Request Meeting"
    sign_in("mentor")
    click_link "Accept Request"
    sign_in("mentee")
    click_link "Cancel Mentorship"
    expect(page).to have_content "You don't have a mentor at the moment."
    clear_database
  end
end

describe "profile page" do
  it "is accessible from the home page" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    expect(page).to have_content "Your Profile"
    clear_database
  end
  
  it "contains fields to change the users profile" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    expect(page).to have_field "first_name"
    expect(page).to have_field "surname"
    expect(page).to have_select "year_of_birth"
    expect(page).to have_select "gender"
    expect(page).to have_field "contact_number"
    expect(page).to have_select "deg_id"
    expect(page).to have_select "deg_year"
    expect(page).to have_field "major_interest"
    expect(page).to have_field "profile_text"
    expect(page).to have_button "submit_change_details"
    clear_database
  end
  
  it "allows the user to edit and save their profile" do
    add_user("mentee")
    sign_in("mentee")
    click_link "Profile"
    fill_profile
    click_button "submit_change_details"
    visit "/profilecreate"
    expect(page).to have_field "first_name", with: "Joe"
    expect(page).to have_field "surname", with: "Bloggs"
    expect(page).to have_field "contact_number", with: "07415638951"
    expect(page).to have_field "major_interest", with: "Cycling"
    clear_database
  end
  
  it "redirects to login if not logged in" do
    visit "/profilecreate"
    expect(page).to have_content "Login"
    clear_database
  end
  
  it "allows mentors to change their profile" do
    add_user("mentor")
    sign_in("mentor")
    click_link "Profile"
    fill_in "first_name", with: "Joe"
    fill_in "surname", with: "Bloggs"
    click_button "submit_change_details"
    visit "/profilecreate"
    expect(page).to have_field "first_name", with: "Joe"
    expect(page).to have_field "surname", with: "Bloggs"
    clear_database
  end
end

describe "the default page" do
  it "will redirect to the login page if not logged in" do
    visit "/"
    expect(page).to have_content "Login"
    clear_database
  end
  
  it "will redirect to the home page if logged in" do
    add_user("mentee")
    sign_in("mentee")
    visit "/"
    expect(page).to have_content "Welcome, mentee!"
    clear_database
  end
end

describe "page not found page" do
  it "will redirect if page not found" do
    visit "/jhkdsjlakhd"
    expect(page).to have_content "Error 404: Page not found"
    clear_database
  end
end

# describe "mentor profile viewer" do
#   it "the mentee can view the information of a mentor" do
#     add_user("mentor")
#     sign_in("mentor")
#     visit "/profilecreate"
#     fill_in "first_name", with: "Joe"
#     fill_in "surname", with: "Bloggs"
#     fill_in "contact_number", with: "04156789541"
#     fill_in "job_deg_cosmetic_name", with: "CEO"
#     fill_in "major_interest", with: "Cycling"
#     click_link "Logout"
#     visit "/login"
#     add_user("mentee")
#     sign_in("mentee")
#     visit "profile"
#     expect(page).to have_content "Major Interest: Cycling"
#   end
# end