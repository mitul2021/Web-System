get "/multichoicesurvey" do
    @role = nil
    @courses = Course.all()
    #user_status is the role cookie 
    @role = request.cookies["user_status"] #expects a 'role' session cookie to be set when user logs in
    erb :multichoicesurvey
end
#i think this code may need to go in process-multichoicesurvey.rb
#nvm it doesnt cuz this code needs to run when the page opens so it knows to display the questionaire for mentee or mentor

#this should work now, it just sets up the @role so the view can query if the currently signed in user is a mentee or mentor and
    #display the right questions

#may be helpful to deny viewing the page if role is nil
