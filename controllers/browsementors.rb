get "/browsementors" do
    if session[:loggedin]
        @mentors = User.where(user_type: "mentor")
        erb :browsementors
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end