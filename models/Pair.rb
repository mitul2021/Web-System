class Pair < Sequel::Model
    
    
    def validate
        super
        
        #if !(mentor_id.is_a? Integer)
        #    errors.add("mentor_id", "mentor_id is not a number")
        #    
        #end
        #
        #if !(mentee_id.is_a? Integer)
        #    errors.add("mentee_id", "mentee_id is not a number")
        #end
        #
        #if exist?
        #    errors.add("general", "there already exists such a request in DB") 
        #end
#
        ##checking if the mentor already has 10 or more ongoing requests
        #if (Pair.where(mentor_id: mentor_id, status: 0).count()>=10) 
        #    errors.add("tooManyRequests","this mentor has to many requests")
        #end
        # 
        #return errors.empty? #if there are no errors we are good to go, and returns true

        errors.add(:mentee_id, 'is nil') if !mentee_id || mentee_id.nil? 
        errors.add(:mentee_id, 'mentee id cannot be negative') if mentee_id<=0

        errors.add(:mentor_id, 'is nil') if !mentor_id || mentor_id.nil? 
        errors.add(:mentor_id, 'mentor id cannot be negative') if mentor_id<=0
        
        errors.add(:status, 'status can only be integer in range [0,6]') if !(status.between?(0,6))

        errors.add(:pair_id, 'by status 0 number of pairs for one mentee should be 0') if (status==0 && numOfPairs!=0)
        errors.add(:pair_id, 'by status in range [1,6] number of pairs for one mentee should be 1') if (status.between?(1,6) && numOfPairs!=1)
    end
    
    def exist?
        #db_pair_array = Pair.all
        #db_pair_array.each do |record|
        #    # Returns true if your id is already in the record for pairs
        #    return true if ((record.mentee_id==self.mentee_id))
        #end
        #return false

        #this function is meant to check if there exist more then one db record coneccted with same mentee

        
    end

    #this function returns number of relationships of one mentee
    #should be equal to 0 if current status is 0,
    #should be equal to 1 if current status is [1,6]
    def numOfPairs #for one mentee
        count = 0
        Pair.all.each do |record|
            count += 1 if (record.mentee_id==self.mentee_id)
        end
        return count
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