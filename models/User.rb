
class User < Sequel::Model
    
    @password_repeat #temporary variable to compare passwords,won't be stored in database
    
    def set_password_repeat(p)
        @password_repeat = p
    end
    
    def password_repeat #getter for the password_repeat field
        @password_repeat
    end
    
    
    def load(params)
        self.email = params.fetch("email"," ").strip
        self.password = params.fetch("password"," ").strip
        self.user_type = params.fetch("user_type"," ").strip
    end
    
    def validate
        super
        errors.add("email", "email cannot be empty") if email.empty?
        errors.add("password", "password cannot be empty") if password.empty?
        errors.add("password_repeat", "password repeacannot be empty") if @password_repeat.empty?
        errors.add("password_repeat", "the passwords are not the same") if @password_repeat!=password
        errors.add("password", "password must be at least 8 characters long") if password.length<8
        errors.add("email", "there exist user with such email address") if self.exist?
        
        
        
        return errors.empty? #if there are no errors we are good to go, and returns true
        
    end
    
    def exist?
        db_user = User.first(email: email)
        
        #if user is nil return false, if db_user exists and it has the same password return true
        return !db_user.nil? && db_user.password == self.password
    end
    
end

