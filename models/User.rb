
class User < Sequel::Model
    
    def load(email, password)
        self.email = email
        self.password = password
    end
    
    def exist?
        first_user = User.first(email: email)
        if first_user.nil?
            return false
        elsif first_user.password = self.password
            return true
        else
            return false
        end
    end
    
end

