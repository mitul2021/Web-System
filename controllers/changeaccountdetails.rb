get "/changeaccountdetails" do
    
    @form_number = params.fetch("form", " ").strip.to_i
        
    erb :changeaccountdetails

end

post "/changeaccountdetails" do
    type = params.fetch("number"," ").strip.to_i
    puts "Type of the form #{type}"

    @errors = {
        "email" => [],
        "new_email" => [],
        "password" => [],
        "new_password" => [],
        "repeat_password" => [],
        "recovery_code" => []
    }

    case type
    when 1 then handleType1(params)
    when 2 then handleType2(params)    
    when 3 then handleType3(params)
    when 4 then handleType4(params)
    else
        "You gave me #{type} -- I have no idea what to do with that."
    end

    have_errors = false

    @errors.each do |key, value|
        have_errors = true unless value.empty?
    end

    if have_errors #if there are any error maessages
        @form_number = type
        erb :changeaccountdetails
    else #no errors

        #Redirecting and cookies
        case type
        when 1,2
            #triggering the cookie that the message is displayed in /profilecreate page
            response.set_cookie("change-from-profile-popup", value: 'true')
            #1, #2 redirecting to profile page
            redirect "/profilecreate"
        when 3,4
            #triggering the cookie that the message is displayed in /login page
            response.set_cookie("change-from-login-popup", value: 'true')
            #3, #4 redirecting to login page,
            redirect "/login"
        end
    end
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

    return  @errors["password"].empty? && @errors["new_email"].empty?
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

def validateUser2(data) #password, new_password, repeat_password
    
    (@errors["password"] << "entered password is incorrect") unless data[0]==User[session[:user_id]].password
    (@errors["password"] << "password cannot be empty") if data[0].empty?
    (@errors["new_password"] << "desired password cannot be empty") if data[1].empty?
    (@errors["repeat_password"] << "repeated password cannot be empty") if data[2].empty?
    (@errors["repeat_password"] << "repeated password does not match") if !(data[1].eql?(data[2]))
    (@errors["new_password"] << "new password cannot be the same as your current password") if (data[0].eql?(data[1]))
    (@errors["new_password"] << "new password should be at least 8 characters long") if data[1].length<8
    (@errors["new_password"] << "new password cannot be empty") if data[1].empty?
    
    return  @errors["password"].empty? && @errors["new_password"].empty? && @errors["repeat_password"].empty?
    
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
    
    (@errors["new_email"] << "someone already uses this email") unless User.first(email: data[0]).nil?
    (@errors["new_email"] << "your desired email cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["password"] << "entered password is incorrect") if User.first(password: data[1]).nil? 
    (@errors["password"] << "password cannot be empty") if data[1].empty?
    (@errors["recovery_code"] << "there is no user with this recovery code") if User.first(recovery_code: data[2]).nil?
    (@errors["recovery_code"] << "the recovery code and your password do not match") if User.first(recovery_code: data[2]).nil? || !(User.first(recovery_code: data[2]).password.eql?(data[1]))
    (@errors["recovery_code"] << "the recovery code cannot be empty") if data[2].empty?
    
    return  @errors["new_email"].empty? && @errors["password"].empty? && @errors["recovery_code"].empty? 
                
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
    
    (@errors["email"] << "entered email is incorrect") if data[0]==User.first(email: data[0]).nil?
    (@errors["email"] << "your email cannot be empty") if data[0].nil? || data[0].empty?
    (@errors["new_password"] << "new password should be at least 8 characters long") if data[1].length<8
    (@errors["new_password"] << "your desired password cannot be empty") if data[1].empty?
    (@errors["new_password"] << "old and new password must be different") if !(User.first(password: data[1]).nil?) 
    (@errors["repeat_password"] << "repeated password does not match") if !(data[1].eql?(data[2]))
    (@errors["repeat_password"] << "repeated password cannot be empty") if data[2].empty?
    (@errors["recovery_code"] << "there is no user with this recovery code") if User.first(recovery_code: data[3]).nil?
    (@errors["recovery_code"] << "the recovery code and your email do not match") if (User.first(recovery_code: data[3]).nil?) || !(User.first(recovery_code: data[3]).email.eql?(data[0]))
    (@errors["recovery_code"] << "the recovery code cannot be empty") if data[3].empty?
        
    return  @errors["email"].empty? && @errors["new_password"].empty? && @errors["repeat_password"].empty? && @errors["recovery_code"].empty?    
        
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
