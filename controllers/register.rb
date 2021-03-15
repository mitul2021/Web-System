get "/register" do
   erb :register
end

post "/register" do
    #user validation
    if(params["password"]==params["password_repeat"])
        @user = User.new
        @user.load(params)
    
        if(@user.valid? && !@user.exist?) #those functions need to be implemented
            @user.save_changes
            puts "SUCCESS, There is new entry in the DB"
        
            redirect "/register-successfully"
        end
    else 
        erb :register
    end
end