get "/" do
    if session[:loggedin]
        redirect "/index"
    else
        redirect "/login"
    end 
end



get "/index" do
    
    if session[:loggedin]
        
			#NEW PAIRING SYSTEM COOKIES NEED TO BE IMPLEMENTED
#         cookie = request.cookies.fetch("decline-popup",0) #reading the cookie
#         @just_declined = true if cookie == "true" #used by view to display the message
#         response.delete_cookie("decline-popup") #deleting the cookie
        
#         cookie = request.cookies.fetch("cancel-popup",0) #reading the cookie
#         @just_cancelled = true if cookie == "true" #used by view to display the message
#         response.delete_cookie("cancel-popup") #deleting the cookie
        
#         cookie = request.cookies.fetch("accept-popup",0) #reading the cookie
#         @just_accepted = true if cookie == "true" #used by view to display the message
#         response.delete_cookie("accept-popup") #deleting the cookie


        @user_id = session[:user_id]
        puts @user_id
        erb :index
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end  
end