get "/profilecreate" do
    if session[:loggedin]
        @role = session[:user_type]
        @user_id = session[:user_id]
			  @user = User.first(id: @user_id)
			
        @change = false
        @change = true if params["change"].eql?("true")

        #EXPERIMANTAL HANDLING INTERESTS
        @numOfInterests = Interest.all.size() #maximum
        puts @numOfInterests
        
        @usr_interests = Userinterest.where(user_id: @user_id)
        @numOfUserInterests = @usr_interests.count  #default
        puts "numOfUserInterests #{@numOfUserInterests}"
        
        erb :profilecreate
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end

post "/profilecreate" do
    
    @user_id = session[:user_id]
    @user = User[@user_id]
    
    
    
    
    #here we need to get rid of the all old record
    Userinterest.where(user_id: @user_id).each do |interest|
        interest.delete
    end
    #loading all user interests
    for i in 0...Interest.all.size()
        load_userinterest(params, @user_id,i)
    end

    case session[:user_type]
    when "mentee"
        @user.load_details_mentee(params)
    when "mentor", "adminmentor"
        @user.load_details_mentor(params)
    when "admin"    
        @user.load_details_admin(params) 
    end    
    
    
    if @user.valid_details?
       @user.save_changes
    end
    
    redirect "/profilecreate"
end


def load_userinterest(params, user_id, i)

    interest_id = params.fetch("interest_id_#{i}"," ").strip
    #puts "This is choosen interest's ID #{i_id}"

    if(Userinterest.where(user_id: user_id, interest_id: interest_id).empty?)
        @userinterest = Userinterest.new
        @userinterest.user_id = user_id
        @userinterest.interest_id = interest_id

        if @userinterest.valid?
            @userinterest.save_changes
        else
            puts "LOADING USER INTEREST GONE WRONG"
        end
    else
        puts "We already have such user interest nothing to do"
    end
end