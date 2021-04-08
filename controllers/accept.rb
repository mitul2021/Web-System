post "/accept" do
    
    puts "This is mentor's ID: #{session[:user_id]}"
    
    @pairID = params["pair_id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
    @pair = Pair[@pairID]
    
    #If you are a mentor AND if your id is equal to the id that exists in a record in the pairs table
    #The second part of the if ensures that you cannot modify someone else's mentorship and vice versa
    if(session[:user_type].eql?("mentor")) && (session[:user_id].eql?(@pair.mentor_id))
        
        puts "Mentor entered"
        
        if Pair.id_exists?(@pairID)
            
            @pair.status = 1
            @pair.save_changes(validate: false) # Updates DB without validation (not secure so will have to be changed for iteration 2)
            response.set_cookie("accept-popup", value: 'true')
        end
    end
    redirect "/index"
end