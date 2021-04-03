class Userinterest < Sequel::Model

    def validate
        super
        return false if self.interest_id.nil?
        return true
            
    end

end