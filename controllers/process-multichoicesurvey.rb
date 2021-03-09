get "/process-multichoicesurvey" do
    
    @firstname = params["first_name"]
    @surname = params["surname"]
    @yearofbirth = params["year_of_birth"]
    @contactnumber = params["contact_number"]
    @course = params["course"]
    @degreeyear = params["degree_year"]
    @intrests = params["intrests"]
    @othernotes = params["other_notes"]
    
    @jobtitle = params["job_title"]
    @jobinfo = params["form_field_mentor3"]
end