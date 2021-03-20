get "/decline" do
    puts "This is mentor's ID: #{session[:user_id]}"
    
    if(session[:user_type].eql?("mentor"))
        @pairID = params["id"].to_i #Retrieves the id from the params hash and sets it to pairID and converts to an integer
        puts "Mentor want to delete pair"
        if Pair.id_exists?(@pairID)
            @pair = Pair[@pairID]
            @pair.delete
            #@pair.save_changes(validate: false) maybe we don't need that
        end
    end
    redirect "/index"
end



    
    