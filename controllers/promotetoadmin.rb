post "/promotetoadmin" do

	user_id = params.fetch("user_id","").strip.to_i	
	user = User[user_id]
	redirect "/index" if !(promotevalidation?(user))
	user.user_type = "admin"
	
	if(user.valid?)
		deleteUserRecords(user_id) #remove past history, to prevent erorrs
		user.save_changes	
	end
	
	redirect "/userlist"
end

def promotevalidation?(user) #returns true if everythink is ok
	
	me = session[:user_type]
	return false if !(me.eql?("admin") || me.eql?("adminmentor"))
	user_to_promote = user.user_type
	return false if user_to_promote.eql?("admin") || user_to_promote.eql?("adminmentor")
			
	true
end

def deleteUserRecords(user_id) #this fucntion deletes all data assiosiated with previous user type
		deletePairingRecords(user_id)
		deleteUserRequestRecords(user_id)
end

def deletePairingRecords(user_id)
		records = Pair.where(mentee_id: user_id).or(mentor_id: user_id)
		return if records.nil?
		records.each do |record|
			record.delete
		end
end

def deleteUserRequestRecords(user_id)
		records = Userrequest.where(user_id: user_id)
		return if records.nil?
		records.each do |record|
			record.delete
		end
end

