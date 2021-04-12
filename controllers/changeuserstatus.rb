post "/changeuserstatus" do

    user_id = params.fetch("user_id","").strip.to_i
    if (!user_id.nil?)
        
        @user = User[user_id]
        if(!@user.nil?)

            case @user.status
            when 1
                @user.status = 0
                puts "You have successfully suspended user #{user_id}"
                
                response.set_cookie("successfully-suspended-popup", value: 'true')
                
            when 0 
                @user.status = 1
                puts "You have successfully restored user #{user_id}"
                
                response.set_cookie("successfully-restored-popup", value: 'true')
                
            else
                puts "Status is neither 0 nor 1 so it is nil"

                response.set_cookie("status-nil-popup", value: 'true')
                
            end

                @user.save_changes
        else
            puts "user doesn't exist since user is nil"

            response.set_cookie("user-doesn't-exist-popup", value: 'true')
        end

    else
        puts "user_id doesn't exist since user is nil"

        response.set_cookie("user_id-doesn't-exist-popup", value: 'true')
        

    end

    redirect "/userlist"

end