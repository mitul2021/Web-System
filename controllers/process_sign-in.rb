post "/signin" do
    $email = params["email"]
    $password = params["pasword"] #this isnt very secure, want to use a secret session ideally
    #need to create a user object and query db to get if mentee or mentor, and pass to cookie
    #@user = User.new
    #@user.load[] no user model for db, need to get a model without yet knowing for mentee or mentor
    
    
    erb :signin
end