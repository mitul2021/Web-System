post "/process-sign-in" do

    @user = User.new
    @user.load(params) #passes the params from the form straight to the model
    if @user.exist?
        session[:loggedin] = true
        puts "Login succesfull"
        erb :loginsuccessful
    else
        session[:loggedin] = false
        puts "Login unsuccesfull"
        erb :loginunsuccessful
    end
end