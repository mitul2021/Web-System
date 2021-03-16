get "/process-log-out" do #using post to stop acsess from anywhere but logout buttons
    if session[:loggedin]
        #if/when we add cookies they should be cleared here
        session[:loggedin] = false
        erb :logoutsuccessful
    else
        erb :logoutunsuccessful
    end
end