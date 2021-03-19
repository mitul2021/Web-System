get "/request" do
    
    mentee_id = session[:user_id]
    puts "This is mentee's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentee"))
        puts "User is a mentee."
        @request = Request.new

        puts "This is mentor's ID: #{params["id"]}"
        @request.mentor_id = params["id"]
        @request.mentee_id = mentee_id

        #updating DB with new request 
        if @request.valid?
            puts "We have valid request."
            @request.save_changes
            puts "Changes saved. Redirecting..."
            
        else
            puts "Request is invalid."
            puts "#{@request.errors}"
        end
        
        
    end
    
    redirect "/browsementors"
end