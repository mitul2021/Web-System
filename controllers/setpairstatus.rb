post "/setpairstatus" do

    status = params.fetch("status","").strip.to_i
	  old_status = params.fetch("old_status","").strip.to_i
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
            puts new_pair.errors
            #trigger cookie here infroming that sths wrong
        end

    when 1,2,3,4,5,6,7
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
        
    when 8
        #coming from status 0 or 1 or 2 so deleting record since active mentorship hasn't started
        pair_id = params.fetch("pair_id","").strip.to_i
        pair = Pair[pair_id]
        pair.status=status
        pair.delete
        
    else
        puts "Retrieved unhandled status."
    end

	  triggerCookies(status, old_status)
    redirect "#{redirect_path}"

end

def triggerCookies(status, old_status)

		#0->1
		response.set_cookie("mentor-accepts-meeting", value: 'true') if old_status==0 && status==1
	
		#0->8 or 1->8
		response.set_cookie("cancels-meeting", value: 'true') if (old_status==0 || old_status==1) && status==8
		
		#2->3
		response.set_cookie("mentor-accepts-mentorship", value: 'true') if old_status==2 && status==3
		
		#2->8
		response.set_cookie("decline-mentorship", value: 'true') if old_status==2 && status==8
		
		#4->5 or 6->7
		response.set_cookie("agree-on-cancelling", value: 'true') if (old_status==4 && status==5) || (old_status==6 && status==7)
		
		#6->3 or 4->3	
		response.set_cookie("cancel-ongoing-request", value: 'true') if (old_status==6 || old_status==4) && status==3
		
		#1-> 8
		response.set_cookie("mentee-cancels-application", value: 'true') if old_status==1 && status==8
end