get "/request" do
    
    mentee_id = session[:user_id]
    puts "This is mentee's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentee"))
        puts "User is a mentee."
        @pair = Pair.new

        puts "This is mentor's ID: #{params["id"]}"
        @pair.mentor_id = params["id"]
        @pair.mentee_id = mentee_id
        @pair.status = 0 #every request is initially not accepted
        
        #updating DB with new request 
        if @pair.valid?
            puts "We have valid request."
            @pair.save_changes
            puts "Changes saved. Redirecting..."
            
        else
            puts "Request is invalid."
            puts "#{@pair.errors}"
        end
        
        
    end
    
    redirect "/browsementors"
end