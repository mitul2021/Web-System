get "/changeaccountdetails" do
    erb :changeaccountdetails
end


post "/changeaccountdetails" do
    type = params.fetch("number"," ").strip.to_i
    puts "Type of the form #{type}"

    case type
    when 1 
        handleType1(params)
    when 2 
        handleType2(params)    
    when 3 
        handleType3(params)
    when 4 
        handleType4(params)
    else
        "You gave me #{type} -- I have no idea what to do with that."
    end


    #Redirecting and cookies
    case type
    when 1,2
        #1, #2 redirecting to profile page, trigger the popup here
        redirect "/profilecreate"
    when 3,4
        #3, #4 redirecting to login page, trigger the popup here
        redirect "/login"
    end
end

def handleType1(params)
    data = loadFormDataType1(params) #new_email,password
    #validation
    
    #password check
    if data[1]==User[session[:user_id]].password
        puts "The password is correct"
    else
        puts "The password is incorrect"
        #possibly add cookie here, and try again or sth
        return
    end

    #at this stage validation done
    @new_request = Userrequest.new
    @new_request.request_id = 1 #code for changing email
    @new_request.user_id = session[:user_id]
    @new_request.request_data = data[0] #for the request we are entering desired email of the user
    @new_request.status = 0 #code pending request

    if @new_request.valid?
        puts "New request is valid saving changes..."
        @new_request.save_changes
    else
        puts "New request is invalid sth gone wrong."
        #place holder for displaying error messages
        
    end
    

end

def handleType2(params)
    data = loadFormDataType2(params) #password, new_password, repeat_password

end

def handleType3(params)
    data = loadFormDataType3(params) #new_email, recovery_code
end

def handleType4(params)
    data = loadFormDataType4(params) #password, repeat_password, recovery_code
end

def loadFormDataType1(params)
    new_email = params.fetch("new_email"," ").strip
    password = params.fetch("password"," ").strip

    puts "FORM NO.1 new_email: #{new_email}, password: #{password}"
    return [new_email,password]
end

def loadFormDataType2(params)
    password = params.fetch("password"," ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip

    puts "FORM NO.2 password: #{password}, new_password: #{new_password}, repeat_password: #{repeat_password}"
    return [password,new_password,repeat_password]
end

def loadFormDataType3(params)
    new_email = params.fetch("new_email"," ").strip 
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.3 new_email: #{new_email}, recovery_code: #{recovery_code}"
    return [new_email,recovery_code]
end

def loadFormDataType4(params)
    password = params.fetch("password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.4 password: #{password}, repeat_password: #{repeat_password}, recovery_code: #{recovery_code}"
    return [password,repeat_password,recovery_code]
end


