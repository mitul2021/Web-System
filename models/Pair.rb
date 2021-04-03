class Pair < Sequel::Model
    
    
     def validate
        super
        
        if !(mentor_id.is_a? Integer)
            errors.add("mentor_id", "mentor_id is not a number")
            
        end
        
        if !(mentee_id.is_a? Integer)
            errors.add("mentee_id", "mentee_id is not a number")
        end
        
        if exist?
            errors.add("general", "there already exists such a request in DB") 
            #we should here check if mentors_id is actually mentors
        end 
         
        return errors.empty? #if there are no errors we are good to go, and returns true
    end
    
    def exist?
        db_pair_array = Pair.all
        db_pair_array.each do |record|
            # Returns true if your id is already in the record for pairs
            return true if ((record.mentee_id==self.mentee_id))
        end
        return false
    end
    
    def self.id_exists?(id)
        return false if id.nil?
        puts "id is definitely not nil"
        #return false unless id.is_a? Integer # checks that the id is an integer
        #puts "id is definitely an integer"
        return false if Pair[id.to_i].nil? # check the database has a record with this id
        puts "Found in the database, success!"
        return true
    end      
   
end