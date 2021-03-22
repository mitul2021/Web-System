get "/multichoicesurvey" do
    if session[:loggedin]
        @courses = Course.all
        @role = session[:user_type]
        @user = 
        #puts "My role is #{@role}"
        #puts "My login in status is : #{session[:loggedin]}"
        erb :multichoicesurvey
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end
