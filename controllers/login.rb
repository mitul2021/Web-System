get "/" do
    redirect "/signin" unless session[:signedin]
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
