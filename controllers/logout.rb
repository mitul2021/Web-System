get "/logout" do
    session.clear
    erb :logout
end      