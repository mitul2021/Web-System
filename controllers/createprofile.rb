get "/profilecreate" do
    if session[:loggedin]
        @role = session[:user_type]
        erb :profilecreate
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end

post "/profilecreate" do
    #Skeleton block to be implemented for the form's action
end
