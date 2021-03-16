post "process-log-out" do #using post to stop acsess from anywhere but logout buttons
    if session[:signedin]
        #if/when we add cookies they should be cleared here
        session[:signedin] = false
        erb :logoutsuccessful
    else
        erb :logoutunsuccessful
    end
end