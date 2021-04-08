post "/accept" do
    
    puts "This is mentor's ID: #{session[:user_id]}"
    
    @pairID = params["pair_id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
    @pair = Pair[@pairID]
    
    #If you are a mentor AND if your id is equal to the id that exists in a record in the pairs table
    #The second part of the if ensures that you cannot modify someone else's mentorship and vice versa
    if(session[:user_type].eql?("mentor")) && (session[:user_id].eql?(@pair.mentor_id))
        
        puts "Mentor entered"
        
        if Pair.id_exists?(@pairID)
            
            @pair.status = 1
            @pair.save_changes(validate: false) # Updates DB without validation (not secure so will have to be changed for iteration 2)
            response.set_cookie("accept-popup", value: 'true')
        end
    end
    redirect "/index"
end


post "/accept-admin" do #for user requests

    @user_request = Userrequest[params["userrequest_id"]]

    if(session[:user_type].eql?("admin")) && (!@user_request.nil?)
        puts "we are admin, and the user request is not nil"

        type = @user_request.request_id

        case type
        when 1 
            handleChangeEmail(@user_request) #changing email
            #cookie trigger here informing admin that he change the user email succesfully
        when 2 
            handleChangePassword(@user_request) #changing password
            #cookie trigger here nforming admin that he change the user password succesfully
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
        puts "Validation faild in handling email change"
    end
end

def handleChangePassword(user_request)

    if(validation(user_request))
        @user.password = user_request.request_data
        @user.save_changes

        user_request.status = 1
        user_request.save_changes
    else
        puts "Validation faild in handling password change"
    end

end