// For when a mentee clicks on Request Meeting
function requestMeeting() {
    return confirm("Are you sure you want to request a meeting with this mentor?");
}


// For when a mentor clicks on Accept Meeting Request
function acceptMeetingRequest() {
    return confirm("Are you sure you want to accept a meeting request from this mentee?");
}


// For when a mentor clicks on Decline Meeting Request
function declineMeetingRequest() {
    return confirm("Are you sure you want to decline a meeting request from this mentee?. No record at this stage will be kept.")
}


// For when a mentee wants to cancel their ongoing Meeting Request
function cancelMeetingRequest() {
    return confirm("Are you sure you want to cancel your meeting request with this mentor?. No record at this stage will be kept.");
}


// For when a mentee clicks on Request Mentorship
function requestMentorship() {
    return confirm("Are you sure you want to request a mentorship with this mentor?");
}


// For when a mentor clicks on Accept Mentorship Request
function acceptMentorshipRequest() {
    return confirm("Are you sure you want to accept a mentorship request from this mentee?");
}


// For when a mentor clicks on Decline Mentorship Request
function declineMentorshipRequest() {
    return confirm("Are you sure you want to decline a mentorship request from this mentee?. No record at this stage will be kept.");
}


// For when a mentee or mentor clicks on Cancel Mentorship
function cancelMentorship() {
    return confirm("Are you sure you want to cancel mentorship?");
}


// For when a mentee wants to clicks on Cancel Application to cancel the application process for mentoring
function cancelApplication() {
    return confirm("Are you sure you want to cancel your application at this stage?. No record of your current application will be kept.");
}


// For when a mentee wants to clicks on Cancel Mentorship Request
function cancelMentorshipRequest() {
    return confirm("Are you sure you want to cancel your ongoing Mentorship Request?. No record of your current application will be kept.");
}


// For when a mentee clicks on Cancel ongoing Request
function cancelOngoingRequest() {
    return confirm("Are you sure you want to cancel your ongoing request?");
}


// For when a mentee or mentor agree on cancelling their relationship
function agreeOnCancelling() {
    return confirm("Do you agree to cancelling your mentorship?");
}


// For when a mentee clicks on Cancel Request
function cancelRequest() {
    return confirm("Are you sure you want to cancel this request? This action cannot be undone.");
}


// For when a mentor clicks on Accept Request from a mentee
function acceptRequest() {
    return confirm("Are you sure you want to accept this request? This action cannot be undone.");
}


// For when a mentor clicks on Decline Request from a mentee
function declineRequest() {
    return confirm("Are you sure you want to decline this request? This action cannot be undone. No record of the incoming mentee request would be kept.");
}


// For when a admin clicks on Suspend User
function suspendUser() {
    return confirm("Are you sure you want to suspend this user?");
}


// For when a admin clicks on Restore User
function restoreUser() {
    return confirm("Are you sure you want to restore this user?");
}
