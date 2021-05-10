get "/userlist" do
    if session[:loggedin]
        @mentees = User.where(user_type: "mentee")
        @mentors = User.where(user_type: "mentor")
        @admins = User.where(user_type: "admin").or(user_type: "adminmentor")
        
        erb :userlist
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end