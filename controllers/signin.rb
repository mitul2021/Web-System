get "/" do
    redirect "/signin" unless session[:logged_in]
    erb :index
end

get "/logout" do
    session.clear
    erb :logout
end   
   
get "/signin" do
    #@
    
   erb :signin
end
