get "/multichoicesurvey" do
   @role="mentor"
   @role = request.cookies["role_session"] #expects a 'role' session cookie to be set when user logs in
   erb :multichoicesurvey
end