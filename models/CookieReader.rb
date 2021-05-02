class CookieReader

	COOKIE_HASH = { #maps the cookie name to its corresponding message 
		"make-login-popup" => "Login successful",
		"decline-popup" => "You have successfully changed the status of your mentorship.",
		"cancel-popup" => "You have successfully cancelled your mentorship.",
		"make-register-popup" => "You have registered successfully. Your recovery code is: "
		
	}
	
	def self.readCookie(name)
		
		value = request.cookies.fetch(name,0) #if there is no value assigned to the cookie it will become 0
		if(value==0) then return #No cookie found, CookieReader return nothing.
		
		response.delete_cookie(name) #deleting the cookie to prevent triggering when page is refreshed
		
		if(value.eql?("true")) then return COOKIE_HASH[name] #if cookie is triggered return its message
		return COOKIE_HASH[name] + value #for cookies that have other value rather than true

	end
end