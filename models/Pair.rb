class Pair < Sequel::Model
    
    
    def validate
        super
        errors.add(:mentee_id, 'is nil') if !mentee_id || mentee_id.nil? 
        errors.add(:mentee_id, 'mentee id cannot be negative') if mentee_id<=0
        errors.add(:mentee_id, 'user using mentee_id is not mentee') if !(User[mentee_id].user_type.eql?("mentee"))
        

        errors.add(:mentor_id, 'is nil') if !mentor_id || mentor_id.nil? 
        errors.add(:mentor_id, 'mentor id cannot be negative') if mentor_id<=0

        user_type = User[mentor_id].user_type
        errors.add(:mentor_id, 'user using mentor_id is neither mentor nor adminmentor') if !(user_type.eql?("mentor") || user_type.eql?("adminmentor"))
        
        errors.add(:status, 'status can only be integer in range [0,7]') if !(status.between?(0,7))

        #general
        errors.add(:pair_id, 'by status 0 number of pairs for one mentee should be 0') if (status==0 && numOfPairsMentee!=0)
        errors.add(:pair_id, 'by status in range [1,7] number of pairs for one mentee should be 1') if (status.between?(1,7) && numOfPairsMentee > 1)
        
        #checking if the mentor already has 10 or more ongoing requests
        errors.add(:pair_id,"mentor with id #{mentor_id} has to many requests") if (numOfPairsMentor>=10)
    
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
    #should be equal to 1 if current status is [1,7]
    def numOfPairsMentee #for one mentee, doesnt count cancelled ones
        count = 0

        Pair.all.each do |pair|
            count +=1 if ((pair.mentee_id == self.mentee_id) && !(pair.status > 3))
        end

        return count
    end
    def numOfPairsMentor #for one mentor, doesnt count cancelled ones

        count = 0

        Pair.all.each do |pair|
            count +=1 if ((pair.mentor_id == self.mentor_id) && !(pair.status > 3))
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