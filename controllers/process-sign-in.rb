post "/process-sign-in" do
    #$email = params["email"]
    #$password = params["pasword"] #!!! we currently have an issue with retreiving pw, seems to be just whitespace
    #need to create a user object and query db to get if mentee or mentor, and pass to cookie
    #@user = User.new
    #@user.load[] no user model for db, need to get a model without yet knowing for mentee or mentor
    #DB = Sequel.sqlite3("users.sqlite3") #garbage code above get rid of
    
    #puts $email
    #puts $password
    
    ##!!!!!!!!!!!!   this doesnt work properly yet, currently denies valid users
    @user = User.new
    @user.load(params) #passes the params from the form straight to the model
    if @user.exist?
        session[:signedin] = true
        puts 1
        erb :loginsuccessful
    else
        session[:signedin] = false
        puts 2
        erb :loginunsuccessful
    end
    
    #$pw = User.find_by email: $email #from https://guides.rubyonrails.org/active_record_querying.html, finds first record matching conditions
    
end