post "/signin" do
    $email = params["email"]
    $password = params["pasword"] #this isnt very secure, want to use a secret session ideally
    #need to create a user object and query db to get if mentee or mentor, and pass to cookie
    #@user = User.new
    #@user.load[] no user model for db, need to get a model without yet knowing for mentee or mentor
    #DB = Sequel.sqlite3("users.sqlite3") #garbage code above get rid of
    
    $users = User.all
    
    #search users via email
    #get if mentee or mentor
    $user_type = nil
    $users.each do |user|
        if user.email == $email
            $user_type = user.user_type
            break
        end
    end
    
    if user_type != nil
        responce.set_cookie("user_status", value: user_type)
    end
    
    
    erb :signin
end