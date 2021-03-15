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
