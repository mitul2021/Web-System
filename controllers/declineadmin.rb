post "/decline-admin" do #for user requests

    @user_request = Userrequest[params["userrequest_id"]]
    role = session[:user_type]
    if(role.eql?("admin") || role.eql?("adminmentor"))
        puts "we are admin"
        unless (@user_request.nil?)
            puts "request is not nil"
            @user_request.delete

            response.set_cookie("decline-admin", value: 'true')
        end

    end

    redirect "/index"

end

    
    