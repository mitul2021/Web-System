get "/" do
    if session[:loggedin]
        redirect "/index"
    else
        redirect "/login"
    end 
end



get "/index" do
    
    if session[:loggedin]
        
        cookie = request.cookies.fetch("make-login-popup",0) #reading the cookie
        @just_logged_in = true if cookie == "true" #used by view to display the message
        response.delete_cookie("make-login-popup") #deleting the cookie
        
        @user_type = session[:user_type]
        @mentorsID = session[:user_id]
        puts @mentorsID
        erb :index
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end  
end