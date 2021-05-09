class CookieReader

	def self.readCookie(name,request,response)
		
		value = request.cookies.fetch(name, 0) #if there is no value assigned to the cookie it will become 0
 		return if(value==0) #No cookie found, CookieReader return nothing.
		
		response.delete_cookie(name) #Deleting the cookie to prevent displaying the message again when page is refreshed
		
		return COOKIE_HASH[name] if(value.eql?("true")) #Returns the corresponding message from the cookie if the value is true
		
        #for cookies that have other value rather than true, it returns the message with the value
        return COOKIE_HASH[name] + value 
	
    end
	COOKIE_HASH = { #maps the cookie name to its corresponding message 
		
        #userlist
		"successfully-suspended-popup" => "You have successfully suspended this user.",
		"successfully-restored-popup" => "You have successfully restored this user.",
		"status-nil-popup" => "Unexpected error as the status field is nil.",
		"user-doesn't-exist-popup" => "Unexpected error as the user is nil.",
		"user_id-doesn't-exist-popup" => "Unexpected error as the user_id field is nil.",
		"promoted-to-admin"=> "You have successfully promoted this user to admin role",
		
		#profile create
		"change-from-profile-popup" => "You have successfully requested changes. Once an admin approves, you will be able to use your new details to log in.",
		"admin-to-adminmentor-success" => "Now you have capabilities of a mentor as well.",
		"admin-to-adminmentor-failure" => "Unexpected error in switching from admin to adminmentor.",
		"adminmentor-to-admin-success" => "You revoked your mentor role successfully.",
		"adminmentor-to-admin-failure" => "Unexpected error in switching from adminmentor to admin.",
		
        #login
		"make-register-popup" => "You have registered successfully. Your recovery code is: ",
		"change-from-login-popup" => "You have successfully requested changes to your account. Once an admin approves your request, you will be able to use your new details to log in.",
		"redirected-popup" => "You have been redirected because you have not logged in yet.",
		"suspended-user-login-popup" => "You have been suspended. Contact with the system administrator for more details.",
		
        #index
		"make-login-popup" => "Login successful",
		"accept-admin-email" => "You have successfully changed the user's email.",
		"accept-admin-password" => "You have successfully changed the user's password.",
		"accept-admin-username" => "You have successfully changed the user's username.",
		"decline-admin" => "You have successfuly declined the user's request.",
        "mentor-accepts-meeting" => "You have accepted a meeting with the mentee.",
        "cancels-meeting" => "You have cancelled your agreement to have a meeting.",
        "mentor-accepts-mentorship" => "You have accepted the mentorship request from the mentee.",
        "decline-mentorship" => "You have declined the mentorship request.",
        "agree-on-cancelling" => "You have agreed to cancel your mentorship.",
        "cancel-ongoing-request" => "You have successfully cancelled your ongoing request.",
        "mentee-cancels-application" => "You have withdrawn yourself from your current application.",
        "mentee-requests-mentorship" => "You have successfully requested a mentorship with this mentor. Wait for the mentor to accept or decline your request.",          
		
        #mentorlist       
        "mentee-requests-meeting" => "You have successfully requested a meeting with the mentor. Wait for the mentor to accept or decline your request.",
        "mentee-requests-meeting-again" => "You cannot request a meeting with another mentor since you are already in an ongoing mentorship."
        
        }
    
end