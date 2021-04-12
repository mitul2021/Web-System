post "/changeuserstatus" do

    user_id = params.fetch("user_id","").strip.to_i
    if (!user_id.nil?)
        
        @user = User[user_id]
        if(!@user.nil?)

            case @user.status
            when 1
                @user.status = 0
                puts "You have succesfully suspended user #{user_id}"
            when 0 
                @user.status = 1
                puts "You have succesfully restored user #{user_id}"
            else
                puts "status is neither 0 nor 1"
                #error @user.status is nill maybe trigger cookie here
            end

                @user.save_changes
        else
            puts "user doesn't exist"
            #trigger cookie that the was unexpected error (user doesn't exist)
        end

    else
        puts "user_id is nil"
        #trigger cookie that the user id is nil and display it in userlist

    end

    redirect "/userlist"

end