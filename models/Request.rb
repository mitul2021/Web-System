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
    end
    
    
end