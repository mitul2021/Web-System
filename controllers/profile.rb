get "/profile/*" do
    # * = wildcard for user ID
    id_num = params[:splat][0]
    @user = User.where(id=id_num)
end