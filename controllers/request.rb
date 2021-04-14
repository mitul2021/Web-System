post "/request" do
    
    #retreives user id from session key, so it can be added as part of a unique pair in the db
    mentee_id = session[:user_id]
    mentor_id = params["mentor_id"]
    puts "This is mentee's ID: #{mentee_id}"
    
    puts "Mentee id nil? #{mentee_id.nil?}"
    puts "Mentor id nil? #{mentor_id.nil?}"
    puts User[mentor_id].user_type.eql?("mentor")
    puts User[mentor_id].user_type.eql?("adminmentor")
    puts "I am logged in as a mentee? #{session[:user_type].eql?("mentee")}"
    
    
    if(!mentee_id.nil? && !mentor_id.nil? && (User[mentor_id].user_type.eql?("mentor") || User[mentor_id].user_type.eql?("adminmentor")) && session[:user_type].eql?("mentee"))
        puts "User is a mentee."
        
        puts "This is mentor's ID: #{mentor_id}"
        #creates the mentor and mentee id of the pair in the db
        @pair = Pair.new
        @pair.mentee_id = mentee_id
        @pair.mentor_id = mentor_id
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

            if @pair.errors.include?("tooManyRequests")
                response.set_cookie("error-too-many-requests-popup", value: 'true')
            end
            
            puts "Request is invalid."
            puts "#{@pair.errors}"
        end
        
        
    end
    
    redirect "/mentorlist"
end