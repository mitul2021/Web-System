post "/accept-admin" do #for user requests

    @user_request = Userrequest[params["userrequest_id"]]
    role = session[:user_type]
    if(role.eql?("admin") || role.eql?("adminmentor")) && (!@user_request.nil?)
        puts "we are admin, and the user request is not nil"

        type = @user_request.request_id

        case type
        when 1 
            handleChangeEmail(@user_request) #changing email

            #cookie trigger here informing the admin that they changed the user's email successfully
            response.set_cookie("accept-admin-email", value: 'true')
        when 2 
            handleChangePassword(@user_request) #changing password
            
            #cookie trigger here informing the admin that they change the user's password successfully
            response.set_cookie("accept-admin-password", value: 'true')
        when 3
            handleChangeUsername(@user_request) #changing username
            
            #cookie trigger here informing the admin that they change the user's password successfully
            response.set_cookie("accept-admin-username", value: 'true')           
        else
            "You gave me #{type} -- I have no idea what to do with that."
        end



    end

    redirect "/index"

end

def validation(user_request)

    @user = User[user_request.user_id]
    return false if @user.nil?

    return false if user_request.request_data.nil?

    return true

end

def handleChangeEmail(user_request)
    
    if(validation(user_request))
        @user.email = user_request.request_data
        @user.save_changes

        user_request.status = 1
        user_request.save_changes
    else
        puts "Validation failed in handling email change"
    end
end

def handleChangePassword(user_request)

    if(validation(user_request))
        @user.password = user_request.request_data
        @user.save_changes

        user_request.status = 1
        user_request.save_changes
    else
        puts "Validation failed in handling password change"
    end

end

def handleChangeUsername(user_request)
    
    if(validation(user_request))
        @user.username = user_request.request_data
        @user.save_changes

        user_request.status = 1
        user_request.save_changes
    else
        puts "Validation failed in handling username change"
    end
end