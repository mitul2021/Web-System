get "/register" do
   erb :register
end

post "/register" do
    #user validation
    @user = User.new
    @user.load_register(params) #load to the database
    @user.set_password_repeat(params.fetch("password_repeat"," ").strip) #won't be stored in DB
        
    if(@user.valid_register?) #valid? includes password check, and invokes exist?
            puts "Email sent" if sendEmailAfterRegister(@user.email, @user.recovery_code)    
						puts "Emails has been sent to admins" if sendEmailsToAdmins(@user.email, @user.username)
            @user.save_changes
            response.set_cookie("make-register-popup", value: @user.recovery_code)
            redirect "/login"
    else
        erb :register
    end
end

def sendEmailsToAdmins(user_email, username)
		subject = "New user has been registered to the system. "
		message = subject
		message += "User name: #{username}. "
		message += "User's email: #{user_email}. "
		message += "At #{Time.now}. "
		allsent = true
		User.where(user_type: "admin").or(user_type: "adminmentor").each do |admin|
			allsent = false if !sendEmailToAdmin(message, subject, admin.email)
		end
		return allsent
end

def sendEmailToAdmin(message, subject, email)
		puts "Valid email? #{EmailSender.validate_email_address(email)} "
		return false if (!EmailSender.validate_email_address(email))
		EmailSender.send_email(email, subject, message)
end

def sendEmailAfterRegister(email_address, recovery_code)
    return if (!EmailSender.validate_email_address(email_address))
    subject = "Thank you for Registering!"
    message = "Hello. Thanks for registering. "
    message += "Your recovery code is #{recovery_code}, should you need it to change your credentials in case you have lost. "
    message += "You should go to the Profile page to then add any missing details to complete your profile. "
    message += "Further guidance is available in the Home page. "
    
    return EmailSender.send_email(email_address, subject, message) 
end