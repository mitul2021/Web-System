
class User < Sequel::Model
    
    @password_repeat #temporary variable to compare passwords,won't be stored in database
    
    def set_password_repeat(p)
        @password_repeat = p
    end
    
    def password_repeat #getter for the password_repeat field
        @password_repeat
    end
    
    
    def load_register(params)
        self.email = params.fetch("email"," ").strip
        self.password = params.fetch("password"," ").strip
        self.user_type = params.fetch("user_type"," ").strip
    end
    
    def load_login(params)
        self.email = params.fetch("email"," ").strip
        self.password = params.fetch("password"," ").strip
    end
    
    def load_details_mentee(params)

        self.first_name = params.fetch("first_name"," ").strip
        self.surname = params.fetch("surname"," ").strip
        self.age = params.fetch("year_of_birth"," ").strip #to be changed later age -> year_of_birth
        self.gender = params.fetch("gender"," ").strip
        self.contact_number = params.fetch("contact_number"," ").strip
        #self.job_deg_cosmetic_name = params.fetch("job_deg_cosmetic_name"," ").strip
        self.deg_id = params.fetch("deg_id"," ").strip
        self.deg_year = params.fetch("deg_year"," ").strip
        self.major_interest = params.fetch("major_interest"," ").strip
        self.profile_text = params.fetch("profile_text"," ").strip
    end
    
    def load_details_mentor(params)

        self.first_name = params.fetch("first_name"," ").strip
        self.surname = params.fetch("surname"," ").strip
        self.age = params.fetch("year_of_birth"," ").strip #to be changed later age -> year_of_birth
        self.gender = params.fetch("gender"," ").strip
        self.contact_number = params.fetch("contact_number"," ").strip
        self.job_deg_cosmetic_name = params.fetch("job_deg_cosmetic_name"," ").strip
        #self.deg_id = params.fetch("deg_id"," ").strip
        self.profile_text = params.fetch("profile_text"," ").strip
        #self.deg_year = params.fetch("deg_year"," ").strip
        self.major_interest = params.fetch("major_interest"," ").strip
    end
    
    def valid_details?
        validate
        return true
    end
    
    def valid_login? #for the login
        errors.add("email", "Combination of email and password does not match") if !self.exist_login?
        errors.add("password", "The password cannot be empty") if self.password.empty?
        errors.add("email", "The email cannot be empty") if self.email.empty?
        
        return errors.empty? #if there are no errors we are good to go, and returns true
    end
    
    def valid_register? #for the register
        validate
        errors.add("email", "email cannot be empty") if email.empty?
        errors.add("password", "password cannot be empty") if password.empty?
        errors.add("password_repeat", "password repeacannot be empty") if @password_repeat.empty?
        errors.add("password_repeat", "the passwords are not the same") if @password_repeat!=password
        errors.add("password", "password must be at least 8 characters long") if password.length<8
        errors.add("email", "there exist user with such email address") if exist?
        
        
        
        return errors.empty? #if there are no errors we are good to go, and returns true
        
    end
    
    def exist? #for the register
        db_user = User.first(email: email)
        
        #if user is nil return false, if db_user exists and it has the same password return true
        return !db_user.nil?
    end
    
    def exist_login? #for the login
        db_user = User.first(email: email)
        return !db_user.nil? && db_user.password == self.password
    end
    
end

