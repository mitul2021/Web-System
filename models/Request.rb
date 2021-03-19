class Request < Sequel::Model
    
    
     def validate
        super
        errors.add("mentor_id", "mentor_id cannot be empty") if mentor_id.empty?
        errors.add("mentee_id", "mentee_id cannot be empty") if mentee_id.empty?
         
        return errors.empty? #if there are no errors we are good to go, and returns true
        
    end
end