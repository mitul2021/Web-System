// For when a mentee clicks on Request Meeting
function requestMeeting() {
    return confirm("Are you sure you want to request a meeting with this mentor?");
}

// For when a mentee has to agree on cancelling their mentorship with the mentor
function agreeOnCancelling() {
    return confirm("Do you agree to cancelling your mentorship with this mentor?")
}

// For when a mentee wants to cancel their ongoing Meeting Request
function cancelMeetingRequest() {
    return confirm("Are you sure you want to cancel your meeting request with this mentor?")
}

// For when a mentee or mentor clicks on Cancel Mentorship
function cancelMentorship() {
    return confirm("Are you sure you want to cancel mentorship? This action cannot be undone.");
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
    return confirm("Are you sure you want to decline this request? This action cannot be undone.");
}

// For when a mentee clicks on Request Mentorship
function requestMentorship() {
    return confirm("Are you sure you want to request a mentorship? This action cannot be undone.");
}

// For when a admin clicks on Suspend User
function suspendUser() {
    return confirm("Are you sure you want to suspend this user?");
}

// For when a admin clicks on Restore User
function restoreUser() {
    return confirm("Are you sure you want to restore this user?");
}
