class CookieReader

	COOKIE_HASH = { #maps the cookie name to its corresponding message 
		"make-login-popup" => "Login successful",
		"decline-popup" => "You have successfully changed the status of your mentorship.",
		"cancel-popup" => "You have successfully cancelled your mentorship.",
		"make-register-popup" => "You have registered successfully. Your recovery code is: "
		
	}
	
	def readCookie(name)
		
		value = request.cookies.fetch(name, 0) #if there is no value assigned to the cookie it will become 0
 		return if(value==0) #No cookie found, CookieReader return nothing.
		
		response.delete_cookie(name) #Deleting the cookie to prevent displaying the message again when page is refreshed
		
		return COOKIE_HASH[name] if(value.eql?("true")) #Returns the corresponding message from the cookie if the value is true
		
        #for cookies that have other value rather than true, it returns the message with the value
        return COOKIE_HASH[name] + value 
	
    end
    
end