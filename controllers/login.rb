get "/" do
    redirect "/login" unless session[:loggedin]
    erb :index
end

get "/logout" do
    session.clear
    erb :logout
end   
   
get "/login" do
   erb :login
end

post "/login" do

    @user = User.new
    @user.load_login(params) #passes the params from the form straight to the model
    if @user.valid_login?
        session[:loggedin] = true
        puts "Login successful"
        redirect "/index"
    else
        session[:loggedin] = false
        puts "Login unsuccessful"
        erb :login
    end
end