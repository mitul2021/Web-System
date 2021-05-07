get "/mentorlist" do
    if session[:loggedin]
        @mentors = User.where(user_type: "mentor")
        @adminmentors = User.where(user_type: "adminmentor")
        erb :mentorlist
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end