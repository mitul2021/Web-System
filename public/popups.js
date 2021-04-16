// For when a mentee clicks on Request Meeting
function requestMeeting() {
    return confirm("Are you sure you want to request a meeting with this mentor?");
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

// For when a mentor clicks on Deny Request from a mentee
function denyRequest() {
    return confirm("Are you sure you want to deny this request? This action cannot be undone.");
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
