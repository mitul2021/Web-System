get "/profilecreate" do
    if session[:loggedin]
        erb :profilecreate
    else
        redirect "/login"
    end
end

post "/profilecreate" do
    #Skeleton block to be implemented for the form's action
end
