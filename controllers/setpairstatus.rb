post "/setpairstatus" do

    status = params.fetch("status","").strip.to_i
    redirect_path = params.fetch("path","").strip

    case status
    when 0
        #we dont have a pair yet, we need to fetch data to create one
        mentor_id = params.fetch("mentor_id","").strip.to_i
        mentee_id = params.fetch("mentee_id","").strip.to_i

        new_pair = Pair.new
        new_pair.mentor_id = mentor_id
        new_pair.mentee_id = mentee_id
        new_pair.status = 0 #initail pair status

        if new_pair.valid? #when status zero there shouldnt be any records in the db for that mentor
            puts "Newly created pair with status 0 is valid"
            new_pair.save_changes
            #trigger cookie here informing that we have setup new relations ship
        else
            puts "Newly created pair with status 0 is NOT valid"
            puts pair.errors
            #trigger cookie here infroming that sths wrong
        end

    when 1,2,3,4,5,6
        #pair already exists
        pair_id = params.fetch("pair_id","").strip.to_i
        pair = Pair[pair_id]
        pair.status=status

        if pair.valid? #when status > zero there should be only one pair in the DB
            puts "Pair after changing its status to #{status} is valid."
            pair.save_changes
            #trigger cookie here informing that we have change our relation ship status
            #we can even pass the status in the cookie sth like response.set_cookie(value: #{status})
            #and then read it accordingly
        else
            puts "Pair after changing its status to #{status} is NOT valid."
            puts pair.errors
            #trigger cookie here infroming that sths wrong
        end

    else
        puts "Retrieved unhadled status."
    end


    redirect "#{redirect_path}"

end