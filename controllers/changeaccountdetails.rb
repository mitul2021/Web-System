get "/changeaccountdetails" do
    erb :changeaccountdetails
end


post "/changeaccountdetails" do
    type = params.fetch("number"," ").strip.to_i
    puts "Type of the form #{type}"

    case type
    when 1 
        loadFormDataType1(params)
    when 2 
        loadFormDataType2(params)    
    when 3 
        loadFormDataType3(params)
    when 4 
        loadFormDataType4(params)
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

def loadFormDataType1(params)
    email = params.fetch("email"," ").strip
    password = params.fetch("password"," ").strip

    puts "FORM NO.1 email: #{email}, password: #{password}"
end

def loadFormDataType2(params)
    password = params.fetch("password"," ").strip
    new_password = params.fetch("new_password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip

    puts "FORM NO.2 password: #{password}, new_password: #{new_password}, repeat_password: #{repeat_password}"
end

def loadFormDataType3(params)
    email = params.fetch("email"," ").strip 
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.3 email: #{email}, recovery_code: #{recovery_code}"
end

def loadFormDataType4(params)
    password = params.fetch("password"," ").strip
    repeat_password = params.fetch("repeat_password"," ").strip
    recovery_code = params.fetch("recovery_code"," ").strip

    puts "FORM NO.4 password: #{password}, repeat_password: #{repeat_password}, recovery_code: #{recovery_code}"
end


