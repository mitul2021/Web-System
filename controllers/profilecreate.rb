get "/profilecreate" do
    if session[:loggedin]
        @role = session[:user_type]
        @user_id = session[:user_id]
        erb :profilecreate
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end

post "/profilecreate" do
    
    @user_id = session[:user_id]
    @user = User[@user_id]
    @user.load_details_mentee(params) if session[:user_type].eql?("mentee")
    @user.load_details_mentor(params) if session[:user_type].eql?("mentor")
    
    if @user.valid_details?
       @user.save_changes
    end
    
    redirect "/profilecreate"
end
