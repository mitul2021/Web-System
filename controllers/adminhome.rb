get "/adminhome" do
    if session[:loggedin]
        erb :adminhome
    else
        response.set_cookie("redirected-popup", value: 'true')
        redirect "/login"
    end
end