get "/profilecreate" do
    if session[:loggedin]
        @role = session[:user_type]
        @user_id = session[:user_id]
        @change = false
        @change = true if params["change"].eql?("true")
        puts params["change"].eql?("true")
        #puts @user_id
        #@user = User.new
        #@user.load_id(@user_id) #loads user from id
        
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
    @user.load_details_admin(params) if session[:user_type].eql?("admin")
    
    if @user.valid_details?
       @user.save_changes
    end
    
    redirect "/profilecreate"
end