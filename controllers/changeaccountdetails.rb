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
        response.set_cookie("change-from-profile-popup", value: 'true')
        redirect "/profilecreate"
    when 3,4
        #3, #4 redirecting to login page, trigger the popup here
        response.set_cookie("change-from-login-popup", value: 'true')
        redirect "/login"
    end
end
# ================
# ==== TYPE 1 ====
# ================

def handleType1(params)
    data = loadFormDataType1(params) #new_email,password
    #validation
    
    return if !validateUser1(data)  #if the validation gone wrong don't go any further just return

    newRequest1(data)

end

def loadFormDataType1(params)
    new_email = params.fetch("new_email"," ").strip
    password = params.fetch("password"," ").strip

    puts "FORM NO.1 new_email: #{new_email}, password: #{password}"
    return [new_email,password]
end

def validateUser1(data)

    #password check
    if data[1]==User[session[:user_id]].password
        puts "The password is correct"
        return true
    else
        puts "The password is incorrect"
        #possibly add cookie here, and try again or sth
        return false
    end

end

def newRequest1(data)

    @new_request = Userrequest.new
    @new_request.request_id = 1 #code for changing email
    @new_request.user_id = session[:user_id]
    @new_request.request_data = data[0] #for the request we are entering desired email of the user
    @new_request.status = 0 #code for pending request

    if @new_request.valid?
        puts "New request is valid saving changes..."
        @new_request.save_changes
    else
        puts "New request is invalid sth gone wrong."
        #place holder for displaying error messages
        #errors.add ....

    end
end

# ================
# ==== TYPE 2 ====
# ================
def handleType2(params)
    data = loadFormDataType2(params) #password, new_password, repeat_password
    #validation
    return if !validateUser2(data)  #if the validation gone wrong don't go any further just return

    newRequest2(data)
end

def loadFormDataType2(params)
    password = params.fetch("password"," ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip

    puts "FORM NO.2 password: #{password}, new_password: #{new_password}, repeat_password: #{repeat_password}"
    return [password,new_password,repeat_password]
end

def validateUser2(data)
    #password check
    if data[0]==User[session[:user_id]].password
        puts "The password is correct"
    else
        puts "The password is incorrect"
        #possibly add cookie here, and try again or sth
        return false
    end
    #check reapeat password
    if data[1]==data[2]
        puts "The passwords match"
    else
        puts "Passwords doesn't match"
        return false
    end

    return true
    
end

def newRequest2(data)

    @new_request = Userrequest.new
    @new_request.request_id = 2 #code for changing password
    @new_request.user_id = session[:user_id]
    @new_request.request_data = data[1] #for the request we are entering desired password
    @new_request.status = 0 #code for pending request

    if @new_request.valid?
        puts "New request is valid saving changes..."
        @new_request.save_changes
    else
        puts "New request is invalid sth gone wrong."
        #place holder for displaying error messages
        #errors.add ....
    end
    
end

# ================
# ==== TYPE 3 ====
# ================

def handleType3(params)
    data = loadFormDataType3(params) #new_email, password, recovery_code
    #validation
    return if !validateUser3(data)  #if the validation gone wrong don't go any further just return

    newRequest3(data)
end

def loadFormDataType3(params)
    new_email = params.fetch("new_email"," ").strip
    password = params.fetch("password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.3 new_email: #{new_email}, password: #{password}, recovery_code: #{recovery_code}"
    return [new_email, password, recovery_code]
end

def validateUser3(data)
    @user = User.first(recovery_code: data[2])
    
    #This is incase the user enters a recovery code that does not exist in the database
    return false if @user.nil?
    
    #Here we are checking that the users' recovery code and password match together in the database record
    return false unless @user.password.eql?(data[1])
    
    return true
    
end

def newRequest3(data)
    @new_request = Userrequest.new
    @new_request.request_id = 1 #code for changing email
    
    #We already know that the user exists since we function called validateUser3
    @new_request.user_id = User.first(recovery_code: data[2]).id
    
    @new_request.request_data = data[0] #for the request we are entering desired email
    @new_request.status = 0 #code for pending request

    if @new_request.valid?
        puts "New request is valid saving changes..."
        @new_request.save_changes
    else
        puts "New request is invalid sth gone wrong."
        #place holder for displaying error messages
        #errors.add ....
    end
end

# ================
# ==== TYPE 4 ====
# ================

def handleType4(params)
    data = loadFormDataType4(params) #current email, new_password, repeat_password, recovery_code
    #validation
    return if !validateUser4(data)  #if the validation gone wrong don't go any further just return

    newRequest4(data)
end

def loadFormDataType4(params)
    email = params.fetch("email", " ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.4 email: #{email}, new_password: #{new_password}, repeat_password: #{repeat_password}, recovery_code: #{recovery_code}"
    return [email, new_password, repeat_password, recovery_code]
end


def validateUser4(data)
    
    @user = User.first(recovery_code: data[3])
    return false if @user.nil?
    
    #Here we are checking that the users' email and recovery code match together in the database record
    return false unless @user.email.eql?(data[0])
    
    return false unless data[1] == data[2]
    
    return true
    
end


def newRequest4(data)
    @new_request = Userrequest.new
    @new_request.request_id = 2 #code for changing password
    
    #We already know that the user exists since we function called validateUser4
    @new_request.user_id = User.first(recovery_code: data[3]).id
    
    @new_request.request_data = data[1] #for the request we are entering desired password
    @new_request.status = 0 #code for pending request

    if @new_request.valid?
        puts "New request is valid saving changes..."
        @new_request.save_changes
    else
        puts "New request is invalid sth gone wrong."
        #place holder for displaying error messages
        #errors.add ....
    end
    
end
