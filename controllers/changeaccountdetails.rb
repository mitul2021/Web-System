get "/changeaccountdetails" do
    
    @form_number = params.fetch("form", " ").strip.to_i
        
    erb :changeaccountdetails

end

post "/changeaccountdetails" do
    type = params.fetch("number"," ").strip.to_i
    puts "Type of the form #{type}"

    @errors = {
        "email" => [],
        "username" => [],
        "new_username" => [],
        "new_email" => [],
        "password" => [],
        "new_password" => [],
        "repeat_password" => [],
        "recovery_code" => [],
        "popup_error" => []
    }

    case type
    when 1 then handleType1(params)
    when 2 then handleType2(params)    
    when 3 then handleType3(params)
    when 4 then handleType4(params)
    when 5 then handleType5(params)
    when 6 then handleType6(params)
    else
        "You gave me #{type} -- I have no idea what to do with that."
    end


    if any_errors?() #if there are any error maessages
        @form_number = type
        @errors["popup_error"].each do |error|
            @same_email_request = true if error.eql?("1")
            @same_password_request = true if error.eql?("2")
            @same_username_request = true if error.eql?("3")
        end
        
        erb :changeaccountdetails #display the page with erormessages
    else #no errors

        #Redirecting and cookies
        case type
        when 1,2,3
            #triggering the cookie that the message is displayed in /profilecreate page
            response.set_cookie("change-from-profile-popup", value: 'true')
            #1, #2, #3 redirecting to profile page
            redirect "/profilecreate"
        when 4,5,6
            #triggering the cookie that the message is displayed in /login page
            response.set_cookie("change-from-login-popup", value: 'true')
            #4, #5, #6 redirecting to login page,
            redirect "/login"
        end
    end
end

def any_errors?() #this function will return true if we have any errors, if no errors are found return false
    @errors.each do |key, value|
        return true if value.any?
    end
    false
end

# ================
# ==== TYPE 1 ====
# ================

def handleType1(params)
    data = loadFormDataType1(params) 
    #validation
    return false if !validateUser1(data)  #if the validation gone wrong don't go any further
    newRequest1(data)
end

def loadFormDataType1(params)
    new_email = params.fetch("new_email"," ").strip
    password = params.fetch("password"," ").strip

    puts "FORM NO.1 new_email: #{new_email}, password: #{password}"
    return [new_email,password]
end

def validateUser1(data) #new_email,password

    (@errors["password"] << "entered password is incorrect") unless data[1]==User[session[:user_id]].password
    (@errors["password"] << "password cannot be empty") if data[1].empty?
    (@errors["new_email"] << "your desired email cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["new_email"] << "someone already uses this email") unless User.first(email: data[0]).nil?
    
    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing email so is 1, status 0, for unresolved requests
    # and we are fetching current user_id
 
    unless Userrequest.where(request_id: 1,status: 0,user_id: session[:user_id]).empty?
        @errors["popup_error"] << "1"
        puts "Same email request detected"
    end
    
    return !any_errors?() #if we dont have any errors return true
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
    data = loadFormDataType2(params) #new_username, password
    #validation
    return if !validateUser2(data)  #if the validation gone wrong don't go any further just return

    newRequest2(data)
end

def loadFormDataType2(params)
    new_username = params.fetch("new_username"," ").strip
    password = params.fetch("password"," ").strip

    puts "FORM NO.2 new_username: #{new_username}, password: #{password}}"
    return [new_username, password]
end

def validateUser2(data) #new_username, password
    
    (@errors["new_username"] << "desired username cannot be empty") if data[0].empty?
    (@errors["new_username"] << "someone already uses this username") unless User.first(username: data[0]).nil?
    
    (@errors["password"] << "entered password is incorrect") unless data[1]==User[session[:user_id]].password
    (@errors["password"] << "password cannot be empty") if data[1].empty?

    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing username so is 3, status 0, for unresolved requests
    # and we are fetching current user_id
    unless Userrequest.where(request_id: 3, status: 0, user_id: session[:user_id]).empty?
        @errors["popup_error"] << "3"
        puts "Same username request detected"
    end
    
    return !any_errors?() #if we dont have any errors return true
end

def newRequest2(data)

    @new_request = Userrequest.new
    @new_request.request_id = 3 #code for changing username
    @new_request.user_id = session[:user_id]
    @new_request.request_data = data[0] #for the request we are entering desired password
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
    data = loadFormDataType3(params) #password, new_password, repeat_password
    #validation
    return if !validateUser3(data)  #if the validation gone wrong don't go any further just return

    newRequest3(data)
end

def loadFormDataType3(params)
    password = params.fetch("password"," ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip

    puts "FORM NO.3 password: #{password}, new_password: #{new_password}, repeat_password: #{repeat_password}"
    return [password,new_password,repeat_password]
end

def validateUser3(data) #password, new_password, repeat_password
    
    (@errors["password"] << "entered password is incorrect") unless data[0]==User[session[:user_id]].password
    (@errors["password"] << "password cannot be empty") if data[0].empty?
    (@errors["new_password"] << "desired password cannot be empty") if data[1].empty?
    (@errors["repeat_password"] << "repeated password cannot be empty") if data[2].empty?
    (@errors["repeat_password"] << "repeated password does not match") if !(data[1].eql?(data[2]))
    (@errors["new_password"] << "new password cannot be the same as your current password") if (data[0].eql?(data[1]))
    (@errors["new_password"] << "new password should be at least 8 characters long") if data[1].length<8
    (@errors["new_password"] << "new password cannot be empty") if data[1].empty?

    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing password so is 2, status 0, for unresolved requests
    # and we are fetching current user_id
    unless Userrequest.where(request_id: 2, status: 0, user_id: session[:user_id]).empty?
        @errors["popup_error"] << "2"
        puts "Same password request detected"
    end
    
    return !any_errors?() #if we dont have any errors return true
end

def newRequest3(data)

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
# ==== TYPE 4 ====
# ================

def handleType4(params)
    data = loadFormDataType4(params) #new_email, password, recovery_code
    #validation
    return if !validateUser4(data)  #if the validation gone wrong don't go any further just return

    newRequest4(data)
end

def loadFormDataType4(params)
    new_email = params.fetch("new_email"," ").strip
    password = params.fetch("password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.4 new_email: #{new_email}, password: #{password}, recovery_code: #{recovery_code}"
    return [new_email, password, recovery_code]
end

def validateUser4(data) #new_email, password, recovery_code
    
    (@errors["new_email"] << "someone already uses this email") unless User.first(email: data[0]).nil?
    (@errors["new_email"] << "your desired email cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["password"] << "entered password is incorrect") if User.first(password: data[1]).nil? 
    (@errors["password"] << "password cannot be empty") if data[1].empty?

    user = User.first(recovery_code: data[2])
    (@errors["recovery_code"] << "there is no user with this recovery code") if user.nil?
    (@errors["recovery_code"] << "the recovery code and your password do not match") if user.nil? || !(user.password.eql?(data[1]))
    (@errors["recovery_code"] << "the recovery code cannot be empty") if data[2].empty?
    
    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing email so is 1, status 0, for unresolved requests
    # and we are fetching current user_id
    if !user.nil? && !Userrequest.where(request_id: 1,status: 0,user_id: user.id).empty?
        @errors["popup_error"] << "1"
        puts "Same email request detected"
    end


    return !any_errors?() #if we dont have any errors return true
                
end

def newRequest4(data)
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
# ==== TYPE 5 ====
# ================

def handleType5(params)
    data = loadFormDataType5(params) #new_username, password, recovery_code
    #validation
    return if !validateUser5(data)  #if the validation gone wrong don't go any further just return

    newRequest5(data)
end

def loadFormDataType5(params)
    new_username = params.fetch("new_username"," ").strip
    password = params.fetch("password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.5 new_username: #{new_username}, password: #{password}, recovery_code: #{recovery_code}"
    return [new_username, password, recovery_code]
end

def validateUser5(data) #new_username, password, recovery_code
    
    (@errors["new_username"] << "someone already uses this username") unless User.first(username: data[0]).nil?
    (@errors["new_username"] << "your desired username cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["password"] << "entered password is incorrect") if User.first(password: data[1]).nil? 
    (@errors["password"] << "password cannot be empty") if data[1].empty?

    user = User.first(recovery_code: data[2])
    (@errors["recovery_code"] << "there is no user with this recovery code") if user.nil?
    (@errors["recovery_code"] << "the recovery code and your password do not match") if user.nil? || !(user.password.eql?(data[1]))
    (@errors["recovery_code"] << "the recovery code cannot be empty") if data[2].empty?
    
    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing username so is 3, status 0, for unresolved requests
    # and we are fetching current user_id
    if !user.nil? && !Userrequest.where(request_id: 3,status: 0,user_id: user.id).empty?
        @errors["popup_error"] << "3"
        puts "Same username request detected"
    end


    return !any_errors?() #if we dont have any errors return true
                
end

def newRequest5(data)
    @new_request = Userrequest.new
    @new_request.request_id = 3 #code for changing username
    
    #We already know that the user exists since we function called validateUser3
    @new_request.user_id = User.first(recovery_code: data[2]).id
    
    @new_request.request_data = data[0] #for the request we are entering desired username
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
# ==== TYPE 6 ====
# ================

def handleType6(params)
    data = loadFormDataType6(params) #current email, new_password, repeat_password, recovery_code
    #validation
    return if !validateUser6(data)  #if the validation gone wrong don't go any further just return

    newRequest6(data)
end

def loadFormDataType6(params)
    email = params.fetch("email", " ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.6 email: #{email}, new_password: #{new_password}, repeat_password: #{repeat_password}, recovery_code: #{recovery_code}"
    return [email, new_password, repeat_password, recovery_code]
end


def validateUser6(data) #email, new_password, repeat_password, recovery_code
    
    (@errors["email"] << "entered email is incorrect") if data[0]==User.first(email: data[0]).nil?
    (@errors["email"] << "your email cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["new_password"] << "new password should be at least 8 characters long") if data[1].length<8
    (@errors["new_password"] << "your desired password cannot be empty") if data[1].empty?
    (@errors["new_password"] << "old and new password must be different") if !(User.first(password: data[1]).nil?) 
    (@errors["repeat_password"] << "repeated password does not match") if !(data[1].eql?(data[2]))
    (@errors["repeat_password"] << "repeated password cannot be empty") if data[2].empty?

    user = User.first(recovery_code: data[3])
    (@errors["recovery_code"] << "there is no user with this recovery code") if user.nil?
    (@errors["recovery_code"] << "the recovery code and your email do not match") if user.nil? || !(user.email.eql?(data[0]))
    (@errors["recovery_code"] << "the recovery code cannot be empty") if data[3].empty?

    #we need to check if similar unresolved request is already in the data base
    #request_id is request type here we are changing password so is 2, status 0, for unresolved requests
    # and we are fetching current user_id
    if !user.nil? && !Userrequest.where(request_id: 2,status: 0,user_id: user.id).empty?
        @errors["popup_error"] << "2"
        puts "Same password request detected"
    end
        
    return !any_errors?() #if we dont have any errors return true
        
end


def newRequest6(data)
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
