get "/" do
    if session[:loggedin]
        redirect "/index"
    else
        redirect "/login"
    end 
end



get "/index" do
    
    if session[:loggedin]
        
        @user_id = session[:user_id]
        puts @user_id
        erb :index
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end  
end