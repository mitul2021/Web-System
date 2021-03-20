get "/decline" do
    puts "This is users's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentor") || session[:user_type].eql?("mentee"))
        @pairID = params["id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
        puts "User want to delete pair"
        if Pair.id_exists?(@pairID)
            @pair = Pair[@pairID]
            @pair.delete
            #@pair.save_changes(validate: false) maybe we don't need that
        end
    end
    redirect "/index"
end



    
    