get "/accept" do
    
    puts "This is mentor's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentor"))
        @pairID = params["id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
        puts "Mentor entered"
        if Pair.id_exists?(@pairID)
            @pair = Pair[@pairID]
            @pair.status = 1
            @pair.save_changes(validate: false) # Updates DB without validation (not secure so will have to be changed for iteration 2)
            response.set_cookie("accept-popup", value: 'true')
        end
    end
    redirect "/index"
end