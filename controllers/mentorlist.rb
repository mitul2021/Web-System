get "/mentorlist" do
    if session[:loggedin]
        @mentors = User.where(user_type: "mentor").or(user_type: "adminmentor")
        @mentee = User[session[:user_id]]
        erb :mentorlist
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end