get "/process-multichoicesurvey" do
    if session[:signedin]
        $email = request.cookies["email"]
        $firstname = params["first_name"]
        $surname = params["surname"]
        $yearofbirth = params["year_of_birth"].to_i
        $contactnumber = params["contact_number"]
        $course = params["course"]
        $degreeyear = params["degree_year"]
        $intrests = params["intrests"]
        $othernotes = params["other_notes"]
        $jobtitle = params["job_title"]
        $jobinfo = params["form_field_mentor3"]
        
        $interest1 = params["interest1"]
        $interest2 = params["interest2"]
        $interest3 = params["interest3"]
        $interest4 = params["interest4"]
        $interest5 = params["interest5"]
        $interest6 = params["interest6"]
        $interest7 = params["interest7"]
        $interest8 = params["interest8"]
        $interest9 = params["interest9"]
        $interest10 = params["interest10"]
        $majorinterest = params["majorinterest"]

        #need to somehow instantiate an existing record in the users table by using
        #the email stored in cookies, then write the details to the db
        #the questions here are outdated with the actual questions we want to ask
        #see in discord, zac posted the questions we want to ask, need to update
        #the view accordingly
        #fill in intrests 1-10 in the db
        $user = User.create({email: $email}) #when instantiating model, need to choose table somehow???

        $year = Time.new.year

        $user.age = $year - $yearofbirth

    end
end