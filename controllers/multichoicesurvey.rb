get "/multichoicesurvey" do
    if session[:loggedin]
        @courses = Courses.all
        @role = session[:user_type]
        #puts "My role is #{@role}"
        #puts "My login in status is : #{session[:loggedin]}"
        erb :multichoicesurvey
    else
        redirect "/login"
    end
end
