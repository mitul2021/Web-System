get "/index" do
    if session[:loggedin]
       erb :index
    else
        #maybe add some cookie here to inform user that is not logged in
        redirect "/login"
    end  
end