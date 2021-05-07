post "/switchadminroles" do
    @user_id = session[:user_id]
    @role = session[:user_type]
    user = User[@user_id]

    if (@role.eql?("admin")) #switching form admin to adminmentor
        puts "Switching from admin to admin mentor"
        user.user_type = "adminmentor"

        if user.valid?
            user.save_changes
            puts "Changing user type from admin to admin mentor was successful"
            session[:user_type] = user.user_type
            #green popup
            response.set_cookie("admin-to-adminmentor-success", value: 'true')
        else
            puts "Changing user type from admin to admin mentor was NOT successful"
            #red popup
            response.set_cookie("admin-to-adminmentor-failure", value: 'true')
        end
        
    elsif (@role.eql?("adminmentor")) #switching form adminmentor to admin
        puts "Switching from adminmentor to admin"
        user.user_type = "admin"

        if user.valid?
            user.save_changes
            puts "Changing user type from adminmentor to admin was successful"
            session[:user_type] = user.user_type
            #green popup
            response.set_cookie("adminmentor-to-admin-success", value: 'true')
        else
            puts "Changing user type from adminmentor to admin was NOT successful"
            #red popup
            response.set_cookie("adminmentor-to-admin-failure", value: 'true')
        end
        
    else
        puts "Some other user got here by accident"
    end

    
    redirect "/profilecreate"
end