def similaritySort(mentee) #requires User object
    @mentors.each do |mentor|
        score = similarityScore(mentee, mentor)
        #write to hash {mentor ==> score}
    end
end

    
#takes in the list of hashes of mentors with their similarities, and returns a sorted list of mentors based on highest similarity
def parseMentorList(mentorList)
end

    
#calculates similarity score based on faculty and intrest
def similarityScore(mentee, mentor)
    #if deg_name_functional are the same (meaning same deg_id, so no need to make a getter for d_g_f), and faculty are same, add +1
    #elsif faculty same, add +0.5
    score = 0
    if ((mentee.deg_id == mentor.deg_id) and (mentee.getfaculty() == mentor.getfaculty()))
        score += 1
    elsif (mentee.getfaculty() == mentor.getfaculty())
        score += 0.5
    end
    
end

#need to figure out how to write hash, need to write parseMentoList

#due to db refactoring we need to write a method to get all interests of a user.
def getMajorInterest(id)
    return Userinterest.first(user_id: mentee_id)

def getInterests(id)
    return Interest[Userinterest.all(user_id: id).interest_id]