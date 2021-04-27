def similaritySort(mentee) #requires metee as User object
    mentorScores = {}
    @mentors.each do |mentor| #@mentors is a global object
        score = similarityScore(mentee, mentor)
        #write to hash {mentor ==> score}
        mentorScores["#{mentor.id}"] = score
    end
    mentorScores = mentorScores.sort_by{|k, v| [-v]}
    return mentorScores
    #returns sorted list of hashes {mentor_id, score}
end

    
#calculates similarity score based on faculty and intrest
def similarityScore(mentee, mentor)
    #if deg_name_functional are the same (meaning same deg_id, so no need to make a getter for d_g_f), and faculty are same, add +1
    #elsif faculty same, add +0.5
    score = 0
    if ((mentee.deg_id == mentor.deg_id) and (Course[mentee.id].faculty == Course[mentor.id].faculty))
        score += 1
    elsif (Course[mentee.id].faculty == Course[mentor.id].faculty)
        score += 0.5
    end
    return score
    
end

#need to figure out how to write hash, need to write parseMentoList

#due to db refactoring we need to write a method to get all interests of a user.
def getMajorInterest(id)
    return Userinterest.first(user_id: mentee_id)
end

def getInterests(id)
    return Interest[Userinterest.all(user_id: id).interest_id]
end