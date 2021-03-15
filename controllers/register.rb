get "/register" do
   erb :register
end

post "/register" do
    #user validation
    @user = User.new
    @user.load(params) #load to the database
    @user.set_password_repeat(params.fetch("password_repeat"," ").strip) #won't be stored in DB
        
    if(@user.valid?) #valid? includes password check, and invokes exist?
            @user.save_changes
            redirect "/register-successfully"
    else 
        erb :register
    end
end