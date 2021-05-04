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
		
		#login
		"make-register-popup" => "You have registered successfully. Your recovery code is: ",
		"change-from-login-popup" => "You have successfully requested changes to your account. Once an admin approves your request, you should be able to log in.",
		"redirected-popup" => "You have been redirected because you have not logged in yet.",
		"suspended-user-login-popup" => "You have been suspended. Contact with the system administrator for more details.",
		#index
		"make-login-popup" => "Login successful",
		"accept-admin-email" => "You have successfuly changed user's email.",
		"accept-admin-password" => "You have successfuly changed user's password.",
		"accept-admin-username" => "You have successfuly changed user's username.",
		"decline-admin" => "You have successfuly declined user's request."
		}
    
end