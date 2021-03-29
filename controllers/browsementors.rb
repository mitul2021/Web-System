get "/browsementors" do
    if session[:loggedin]
        
        cookie = request.cookies.fetch("request-popup", 0) #reading the cookie
        @just_requested = true if cookie == "true" #used by view to display the message
        response.delete_cookie("request-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("error-mentor-exists-popup", 0) #reading the cookie
        @mentor_already_requested = true if cookie == "true" #used by view to display the message
        response.delete_cookie("error-mentor-exists-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("error-mentor_id-not-integer-popup", 0) #reading the cookie
        @mentor_id_not_integer = true if cookie == "true" #used by view to display the message
        response.delete_cookie("error-mentor_id-not-integer-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("error-mentee_id-not-integer-popup", 0) #reading the cookie
        @mentee_id_not_integer = true if cookie == "true" #used by view to display the message
        response.delete_cookie("error-mentee_id-not-integer-popup") #deleting the cookie
        
        @mentors = User.where(user_type: "mentor")
        erb :browsementors
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end