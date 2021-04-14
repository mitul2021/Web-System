
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
        self.username = params.fetch("username"," ").strip
        self.password = params.fetch("password"," ").strip
        self.user_type = params.fetch("user_type"," ").strip
        self.recovery_code = generate_recovery_code()
        self.status = 1
    end
    
    
    def load_login(params)
        text = params.fetch("text", " ").strip
        if text.include?("@")
            self.email = text
            self.username = " ".strip
        else
            self.username = text
            self.email = " ".strip
        end
        self.password = params.fetch("password"," ").strip        
    end
    
    
    def load_id(id) #loads user via their id
        if session[:loggedin] #wont log in with id unless session is logged in for security
            self.id = id
        end
    end
    
    
    def load_details_mentee(params)

        
        self.first_name = params.fetch("first_name"," ").strip
        self.surname = params.fetch("surname"," ").strip
        self.year_of_birth = params.fetch("year_of_birth"," ").strip
        self.gender = params.fetch("gender"," ").strip
        self.contact_number = params.fetch("contact_number"," ").strip
        self.deg_id = params.fetch("deg_id"," ").strip
        self.deg_year = params.fetch("deg_year"," ").strip
        self.profile_text = params.fetch("profile_text"," ").strip
    
    end
    
    
    def load_details_mentor(params)

        self.first_name = params.fetch("first_name"," ").strip
        self.surname = params.fetch("surname"," ").strip
        self.year_of_birth = params.fetch("year_of_birth"," ").strip #to be changed later age -> year_of_birth
        self.gender = params.fetch("gender"," ").strip
        self.contact_number = params.fetch("contact_number"," ").strip
        self.job_deg_cosmetic_name = params.fetch("job_deg_cosmetic_name"," ").strip
        #self.deg_id = params.fetch("deg_id"," ").strip
        self.profile_text = params.fetch("profile_text"," ").strip
        #self.deg_year = params.fetch("deg_year"," ").strip
        #self.major_interest = params.fetch("major_interest"," ").strip
    end
    
    
    def load_details_admin(params)

        self.first_name = params.fetch("first_name"," ").strip
        self.surname = params.fetch("surname"," ").strip
        self.year_of_birth = params.fetch("year_of_birth"," ").strip #to be changed later age -> year_of_birth
        self.gender = params.fetch("gender"," ").strip
        self.contact_number = params.fetch("contact_number"," ").strip
        self.profile_text = params.fetch("profile_text"," ").strip
    
    end
  
    def valid_details?
        validate
        return true
    end
    
    def valid_login? #for the login
        
        # If the user has entered email instead of username
        if (self.username.empty? && !(self.email.empty?))
            errors.add("email", "Combination of email and password does not match") if !self.exist_login?
        # If the user has entered username instead of email
        elsif (!(self.username.empty?) && (self.email.empty?))        
            errors.add("username", "Combination of username and password does not match") if !self.exist_login?
        else # If the user entered nothing
            errors.add("text", "Your Email or Username cannot be empty") if self.username.empty? && self.password.empty?
        end
        

        # If the user didn't enter their password
        errors.add("password", "The password cannot be empty") if self.password.empty?
        
        
        return errors.empty? #if there are no errors we are good to go, and returns true
    end
    
    def valid_register? #for the register
        validate
        errors.add("email", "email cannot be empty") if email.empty?
        errors.add("email", "there exist user with such email address") if exist_register?
        errors.add("email", "this email addres is of not approved university") unless approved_email?
        errors.add("password", "password cannot be empty") if password.empty?
        errors.add("password", "password must be at least 8 characters long") if password.length<8
        errors.add("username", "username cannot be empty") if username.empty?
        errors.add("username", "there exists a user with such a username") if exist_register?
        errors.add("password_repeat", "password repeat cannot be empty") if @password_repeat.empty?
        errors.add("password_repeat", "the passwords are not the same") if @password_repeat!=password
    
        return errors.empty? #if there are no errors we are good to go, and returns true
        
    end
    
    
    #Check if it has to be modified now that there is a username field
    
    def exist_register? #for the register
        db_user_email = User.first(email: email)
        
        #if user is nil return false, if db_user exists and it has the same password return true
        return (!db_user_email.nil?)
    end
    
    def exist_login? #for the login
        db_user_email = User.first(email: email)
        db_user_username = User.first(username: username)
        puts "Is the email nil? #{db_user_email.nil?}"
        puts "Is the username nil? #{db_user_username.nil?}"
        puts "Email: #{self.email}"
        puts "Username: #{self.username}"
        return ((!db_user_email.nil? && db_user_email.password == self.password) || (!db_user_username.nil? && db_user_username.password == self.password))
    end
  
    def generate_recovery_code
        code = SecureRandom.alphanumeric(6).upcase
        puts "This is newly generated recovery code: #{code}"
        return code
    end

    def approved_email?
        University.all.each do |uni|
            return true if self.email.include?(uni.email)
        end        
        false
    end
    
end

