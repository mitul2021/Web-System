get "/process-multichoicesurvey" do
    if session[:loggedin]
        
        user_id = session[:user_id]
        @user = User.new
        @user.load_id(user_id) #loads user from id
        
        if @user.valid_login?
            @user.load_survey(params)
        end

    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end