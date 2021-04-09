class Userrequest < Sequel::Model
    
#     def valid? #for when the user is requesting to change their details
#         validate
#         errors.add("email", "email cannot be empty") if request_data.empty?
#         errors.add("password", "password cannot be empty") if password.empty?
#         errors.add("password_repeat", "password repeat cannot be empty") if @password_repeat.empty?
#         errors.add("password_repeat", "the passwords are not the same") if @password_repeat!=password
#         errors.add("password", "password must be at least 8 characters long") if password.length<8
#         errors.add("email", "there exist user with such email address") if exist? #User might want a desired email that is already in the database

#         return errors.empty? #if there are no errors we are good to go, and returns true

#     end
    
#     def exist? #for checking if the user's email already exists in the database
#         db_user = User[user_id]
        
#         #if user is nil return false, if db_user exists and it has the same password return true
#         return !db_user.nil?
#     end
        
end