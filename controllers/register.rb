get "/register" do
   erb :register
end

post "/register" do
    #user validation
    @user = User.new
    @user.email = params["email"]
    @user.password = params["password"]
    @user.user_type = params["user_type"].to_s #becomes a nil for now, needs debugging
    #waiting for the reply on the discussion board
    
    if(@user.valid? && !@user.exist?) #those functions need to be implemented
        
        @user.save_changes
        puts "SUCCESS, There is new entry in the DB"
        
        redirect "/register-successfully"
    else 
        erb :register
    end
end