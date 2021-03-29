get "/request" do
    
    #retreives user id from session key, so it can be added as part of a unuiqe pair in the db
    mentee_id = session[:user_id]
    puts "This is mentee's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentee"))
        puts "User is a mentee."
        @pair = Pair.new

        puts "This is mentor's ID: #{params["id"]}"
        #creates the mentor and mentee id of the pair in the db
        @pair.mentor_id = params["id"]
        @pair.mentee_id = mentee_id
        @pair.status = 0 #every request is initially not accepted
        
        #updating DB with new request 
        if @pair.valid?
            puts "We have valid request."
            @pair.save_changes
            puts "Changes saved. Redirecting..."
            response.set_cookie("request-popup", value: 'true')
            
        else
            if @pair.errors.include?("general")
                response.set_cookie("error-mentor-exists-popup", value: 'true')
            end
            
            if @pair.errors.include?("mentor_id")
                response.set_cookie("error-mentor_id-not-integer-popup", value: 'true')
            end
            
            if @pair.errors.include?("mentee_id")
                response.set_cookie("error-mentee_id-not-integer-popup", value: 'true')
            end
            
            puts "Request is invalid."
            puts "#{@pair.errors}"
        end
        
        
    end
    
    redirect "/browsementors"
end