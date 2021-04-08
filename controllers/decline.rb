post "/decline" do
    puts "This is users's ID: #{session[:user_id]}"
    
    @pairID = params["pair_id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
    @pair = Pair[@pairID]
    
    #If you are a mentee -AND- you are checking that it is the correct mentee_id OR you are a mentor -AND- you are checking that it is the correct mentor_id
    #The second and fourth part of the if ensures that you cannot modify someone else's mentorship and vice versa
    if ((session[:user_type].eql?("mentee") && (session[:user_id].eql?(@pair.mentee_id))) || (session[:user_type].eql?("mentor") && (session[:user_id].eql?(@pair.mentor_id))))
                
        puts "User want to delete pair"
        if Pair.id_exists?(@pairID)            
            @pair.delete
            #@pair.save_changes(validate: false) maybe we don't need that
            response.set_cookie("decline-popup", value: 'true') if session[:user_type].eql?("mentee")
            response.set_cookie("cancel-popup", value: 'true') if session[:user_type].eql?("mentor")
        end
    end
    redirect "/index"
end

post "/decline-admin" do #for user requests

    @user_request = Userrequest[params["userrequest_id"]]

    if(session[:user_type].eql?("admin"))
        puts "we are admin"
        unless (@user_request.nil?)
            puts "request is not nil"
            @user_request.delete
        end

    end

    redirect "/index"

end

    
    