get "/userlist" do
    if session[:loggedin]
        # Body is currently skeleton, will be changed later
        @mentees = User.where(user_type: "mentee")
        @mentors = User.where(user_type: "mentor")
        erb :userlist
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end