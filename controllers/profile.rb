get "/profile/*" do
    
    # Getting the user type
    @role = session[:user_type]
    
    # * = wildcard for user ID
    id_num = params[:splat][0]
    
    # the id_num is the number in the url for that profile 
    @user = User[id_num]
    
    # redirect to the not found page if the user does not even exist
    redirect "/not_found" if @user.nil?
    
    # If you are a mentee
    if @role.eql?("mentee")
        
        # If you want to see other mentee or admin profiles
        if @user.user_type.eql?("mentee") || @user.user_type.eql?("admin")
            # Redirect them to the not found page as they have no access right
            redirect "/not_found"
        end
    
    elsif @role.eql?("mentor")
        
        # List of pairs where the logged in user is a mentor
        @pairs = Pair.where(mentor_id: session[:user_id])
        
        # New array that will only contain the IDs that the mentor can view (the IDs will be retrieved by iterating through the pairs like below)
        allowedIDs = Array.new
        
        @pairs.each do |pair|
            # Adding the ids of your mentees only (the ids that you can view)
            # .to_s because we are comparing strings in a later comparison
            allowedIDs.push(pair.mentee_id.to_s)
        end
        
        puts "Here are the allowed IDs: #{allowedIDs}"
        
        # Unless the mentor can view the IDs of the mentee, redirect to not_found page
        if !(allowedIDs.include?(id_num.to_s))
            redirect "/not_found"
        end
        
    elsif @role.eql?("admin")
        # The admins are not restricted to certain profiles as they can view any profile including other admins
    
    else
       # For debugging purposes
       puts "Error: you are not a mentee, mentor or admin."
    end
    
    erb :profile
    
end