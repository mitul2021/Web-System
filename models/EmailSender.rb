class EmailSender

    def self.validate_email_address(email_address)
        email_address =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    end

    def self.send_email(email, subject, body)
        response = Net::HTTP.post_form(URI("http://www.dcs.shef.ac.uk/cgi-intranet/public/FormMail.php"),
                                 "recipients" => email,
                                 "subject" => subject,
                                 "body" => body)
        response.is_a? Net::HTTPSuccess
    end
    
    
    #Function that emails users about an update
    def self.getMessage()
        return "There has been an update. Log in to the system to see the update."
    end
    
    #Function that includes this subject for all mails and users about an update
    def self.getSubject()
        return "University Of Sheffield Mentorship Update"
    end
        
#     EMAIL_HASH = { #maps the combination (array of old status and new status) to the appropriate email subject and message  
        
#         [0, 1] => "There has been an update. Log in to the system to see the update.", 
        
#     }    
    
    
end