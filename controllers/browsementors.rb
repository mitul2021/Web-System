get "/browsementors" do
    if session[:loggedin]
        
        cookie = request.cookies.fetch("request-popup",0) #reading the cookie
        @just_requested = true if cookie == "true" #used by view to display the message
        response.delete_cookie("request-popup") #deleting the cookie
        
        
        @mentors = User.where(user_type: "mentor")
        erb :browsementors
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end