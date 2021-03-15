
class User < Sequel::Model
    
    
    def load(params)
        self.email = params.fetch("email"," ").strip
        self.password = params.fetch("password"," ").strip
        self.user_type = params.fetch("user_type"," ").strip
    end
    
    def exist?
        db_user = User.first(email: email)
        
        #if user is nil return false, if db_user exists and it has the same password return true
        return !db_user.nil? && db_user.password == self.password
    end
    
end

