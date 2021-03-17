get "/browsementors" do
    if session[:loggedin]
        @mentors = User.where(user_type: "mentor")
        erb :browsementors
    else
        #maybe add some cookie here to inform user that is not logged in
        redirect "/login"
    end
end