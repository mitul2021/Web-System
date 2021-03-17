get "/" do
    if session[:loggedin]
       erb :index
    else
        #maybe add some cookie here to inform user that is not logged in
        redirect "/login"
    end 
end

get "/login" do
    
   cookie = request.cookies.fetch("make-register-popup",0)
  # if cookie == "true"
  # else
  # end
    
   erb :login
end

post "/login" do

    @user = User.new
    @user.load_login(params) #passes the params from the form straight to the model
    if @user.valid_login?
        session[:loggedin] = true
        
        @user = User.first(email: @user.email)
        session[:user_type] = @user.user_type
        
        
        
        puts "Login successful"
        puts "LOGIN CONTROLLER:"
        puts "My role is #{session[:user_type]}"
        puts "My login in status is : #{session[:loggedin]}"
        
        redirect "/index"
    else
        session[:loggedin] = false
        puts "Login unsuccessful"
        erb :login
    end
end