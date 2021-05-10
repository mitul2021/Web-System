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
    #if deg_name_functional are the same, and faculty are same, add +1
    #elsif faculty same, add +0.5
    score = 0
    #if have the same deg_id, we can assume they have the same deg_name_functional, so only need to check deg_id are same instead
    if ((mentee.deg_id == mentor.deg_id) and (Course[mentee.id].faculty == Course[mentor.id].faculty))
        score += 1
    elsif (Course[mentee.id].faculty == Course[mentor.id].faculty)
        score += 0.5
    end
    
    #here, need to add a match score if mentee and mentor have the same interest
    # do this by searching the userinterests table via user_id. If mentee and mentor have same userinterest_id, then its a match
    #  if needed, can give info about what interests match by searching interests table with the interest_id from the userinterests table
        
    @menteeinterests = Userinterest.where(user_id: mentee.id)
    @mentorinterests = Userinterest.where(user_id: mentor.id)
    
    matchingInterest = 0
    
    @menteeinterests.each do |menteeInterest|
        @mentorinterests.each do |mentorInterest|
            if menteeInterest.interest_id == mentorInterest.interest_id
                matchingInterest += 1
            end
        end
    end
    
    if matchingInterest > 0 #if true then match
        score += 1
    end
    
    return score
    
end

#due to db refactoring we need to write a method to get all interests of a user.
def getMajorInterest(id)
    return Userinterest.first(user_id: mentee_id)
end

def getInterests(id)
    return Interest[Userinterest.all(user_id: id).interest_id]
end