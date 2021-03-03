get "/register" do
   erb :register
end

post "/register" do
    @variable = params["password"]
    puts @variable
   erb :register
end