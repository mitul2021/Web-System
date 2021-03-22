get "/login" do
    cookie = request.cookies.fetch("make-register-popup",0)
    if cookie == "true"
        @registered = true
    end
    response.delete_cookie("make-register-popup")
    
    cookie = request.cookies.fetch("redirected-popup",0) #reading the cookie
    @redirected = true if cookie == "true" #used by view to display the message
    response.delete_cookie("redirected-popup") #deleting the cookie
    
    cookie = request.cookies.fetch("redirected-popup",0) #cookie when user requests mentorship
    if cookie == "true"
        puts "successfuly requested mentorship"
        response.delete_cookie("redirected-popup")
    end
    
    erb :login

end

post "/login" do

    @user = User.new
    @user.load_login(params) #passes the params from the form straight to the model
    if @user.valid_login?
        session[:loggedin] = true
        
        @user = User.first(email: @user.email)
        session[:user_id] = @user.id
        puts "THIS IS MY USER'S ID: #{session[:user_id]}"
        session[:user_type] = @user.user_type
        
        
        
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