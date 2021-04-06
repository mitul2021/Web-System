get "/login" do
    cookie = request.cookies.fetch("make-register-popup",0)
    unless cookie.eql?(0)
      @registered = true
      @code = cookie
      puts "This is code after reading cookie #{@code}"
    end
    response.delete_cookie("make-register-popup")
    
    cookie = request.cookies.fetch("redirected-popup",0) #reading the cookie
    @redirected = true if cookie == "true" #used by view to display the message
    response.delete_cookie("redirected-popup") #deleting the cookie
    
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