class Request < Sequel::Model
    
    
     def validate
        super
        errors.add("mentor_id", "mentor_id is not a number") if !(mentor_id.is_a? Integer)
        errors.add("mentee_id", "mentee_id is not a number") if !(mentee_id.is_a? Integer)
        errors.add("general", "there already exists such a request in DB") if exist?
         #we should here check if mentors_id is actually mentors
         
        return errors.empty? #if there are no errors we are good to go, and returns true
    end
    
    def exist?
        db_requests_array = Request.all
        
        db_requests_array.each do |record|
            return true if ((record.mentor_id==self.mentor_id) && (record.mentee_id==self.mentee_id))
        end
        
        return false
        
#         is_nil = (!db_request.nil?)
#         puts "Have we found the DB record?: #{is_nil}"
        
#         puts "OUR MENTOR ID: #{mentor_id}"
#         puts "OUR MENTEE ID: #{mentee_id}"
#         puts
        
#         puts "DB's MENTOR ID: #{db_request.mentor_id}"
#         puts "DB's MENTEE ID: #{db_request.mentee_id}"
#         puts
#         same_mentee_id = db_request.mentee_id.eql?(self.mentee_id)
#         puts "FIRST ID #{self.mentee_id}; SECOND ID #{db_request.mentee_id}"
#         puts "Do we have the same mentee ids? : #{same_mentee_id}"
#         #if user is nil return false, if db_user exists and it has the same password return true
#         return (!db_request.nil?) && (db_request.mentee_id.eql?(self.mentee_id))
    end
    
    
end