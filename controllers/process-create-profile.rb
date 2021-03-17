get "/profilecreate" do
    if session[:loggedin]
        erb :profilecreate
    else
        redirect "/login"
    end
end

