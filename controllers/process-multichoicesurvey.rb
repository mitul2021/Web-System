get "/process-multichoicesurvey" do
    
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


    #need to somehow instantiate an existing record in the users table by using
    #the email stored in cookies, then write the details to the db
    #the questions here are outdated with the actual questions we want to ask
    #see in discord, zac posted the questions we want to ask, need to update
    #the view accordingly
    #fill in intrests 1-10 in the db
    $user = User.create({email: $email}) #when instantiating model, need to choose table somehow???
    $user.email = 
    $user.password =
    $user.first_name = $firstname
    $user.surname = $surname

    $year = Time.new.year

    $user.age = $year - $yearofbirth
    #$user.gender = 
    $user.contact_number = $contactnumber
    #$user.user_type =
    $user.job_deg_cosmetic_name =
    $user.deg_id = 
    $user.profile_text =
    $user.course_year =
    $user.paired_id =
    #skipping intrest fields

end