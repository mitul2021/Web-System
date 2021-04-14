get "/userlist" do
    if session[:loggedin]
        @mentees = User.where(user_type: "mentee")
        @mentors = User.where(user_type: "mentor")
        @admins = User.where(user_type: "admin")
        @adminmentors = User.where(user_type: "adminmentor")
        
        cookie = request.cookies.fetch("successfully-suspended-popup", 0) #reading the cookie
        @successfully_suspended = true if cookie == "true" #used by view to display the message
        response.delete_cookie("successfully-suspended-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("successfully-restored-popup", 0) #reading the cookie
        @successfully_restored = true if cookie == "true" #used by view to display the message
        response.delete_cookie("successfully-restored-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("status-nil-popup", 0) #reading the cookie
        @status_is_nil = true if cookie == "true" #used by view to display the message
        response.delete_cookie("status-nil-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("user-doesn't-exist-popup", 0) #reading the cookie
        @user_nil = true if cookie == "true" #used by view to display the message
        response.delete_cookie("user-doesn't-exist-popup") #deleting the cookie
        
        cookie = request.cookies.fetch("user_id-doesn't-exist-popup", 0) #reading the cookie
        @user_id_nil = true if cookie == "true" #used by view to display the message
        response.delete_cookie("user_id-doesn't-exist-popup") #deleting the cookie
        
        erb :userlist
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end