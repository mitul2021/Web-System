get "/browsementors" do
    @mentors = User.where(user_type: "mentor")
    erb :browsementors
end