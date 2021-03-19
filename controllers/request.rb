get "/register" do
    #@mentor = User[mentors_id] if User.exists?(mentors_id)
    puts session[:user_type]
    if(session[:user_type].eql?("mentee"))
        puts "HELLO MENTEE"
        @request = Request.new

        puts params["id"]
        @request.mentor_id = params["id"]
        
        puts session[:user_id]
        @request.mentee_id = session[:user_id]

        #updating DB with new request 
        if @request.valid?
            puts "We have valid request."
            @request.save_changes
            puts "Changes saved. Redirecting..."
            redirect "/browsementors"
        end
    end
end