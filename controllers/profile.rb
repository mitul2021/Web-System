get "/profile/*" do
    # * = wildcard for user ID
    id_num = params[:splat][0]
    #not_found unless
    @user = User[id_num]
    erb :profile
    
end