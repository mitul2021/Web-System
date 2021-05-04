get "/login" do
    erb :login
end

post "/login" do

    @user = User.new
    @user.load_login(params) #passes the params from the form straight to the model
    if @user.valid_login?
        
        puts "This is email: #{@user.email}"
             
        
        # Checking if there is a record with that username that was entered. If it is nil, it goes to the next line
        @DB_user = User.first(username: @user.username)
        
        @DB_user = User.first(email: @user.email) if @DB_user.nil?

        @user = @DB_user
        puts "Is the user nil? #{@user.nil?}"

        if(@user.status==0)
            response.set_cookie("suspended-user-login-popup", value: 'true')
            redirect "/login"
        end
        
        session[:user_id] = @user.id
       
        puts "THIS IS MY USER'S ID: #{session[:user_id]}"
        session[:user_type] = @user.user_type
        session[:loggedin] = true
        
        
        puts "Login successful"
        puts "LOGIN CONTROLLER:"
        puts "My role is #{session[:user_type]}"
        puts "My login in status is : #{session[:loggedin]}"
        
        response.set_cookie("make-login-popup", value: 'true')
        
        redirect "/index"
    else
        session[:loggedin] = false
        puts "Login unsuccessful"
        erb :login
    end
end