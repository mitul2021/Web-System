get "/changedetails" do   
    if session[:loggedin]
        erb :menteechangedetails
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end