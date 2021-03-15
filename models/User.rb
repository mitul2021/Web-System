
class User < Sequel::Model
    
    def load(params)
        self.email = params.fetch("email"," ").strip
        self.password = params.fetch("password"," ").strip
        self.user_type = params.fetch("user_type"," ").strip
    end
    
    def exist?
        first_user = User.first(email: email)
        
        if first_user.nil?
            return false
        elsif first_user.password == self.password
            return true
        else
            return false
        end
    end
    
end

