get "/index" do
    
    if session[:loggedin]
        
        cookie = request.cookies.fetch("make-login-popup",0) #reading the cookie
        @just_logged_in = true if cookie == "true" #ussed by view to display the message
        response.delete_cookie("make-login-popup") #deleting the cookie
        
        erb :index
    else
        #maybe add some cookie here to inform user that is not logged in
        redirect "/login"
    end  
end