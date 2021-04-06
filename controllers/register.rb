get "/register" do
   erb :register
end

post "/register" do
    #user validation
    @user = User.new
    @user.load_register(params) #load to the database
    @user.set_password_repeat(params.fetch("password_repeat"," ").strip) #won't be stored in DB
        
    if(@user.valid_register?) #valid? includes password check, and invokes exist?
            @user.save_changes
            response.set_cookie("make-register-popup", value: @user.recovery_code)
            redirect "/login"
    else
        erb :register
    end
end