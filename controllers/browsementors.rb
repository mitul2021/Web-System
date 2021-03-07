get "/browsementors" do
    @mentors = Mentor.all
    erb :browsementors
end