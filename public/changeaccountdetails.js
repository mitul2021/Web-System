// For when the user clicks on the button My Email
function desiredEmail() {
    var displayEmail = document.getElementById("displayemailbox");
    
    document.getElementById("changetext").style.display="none";
    document.getElementById("change_email").style.display="none";
    document.getElementById("displayemailbox").removeAttribute("hidden");
    document.getElementById("change_password").style.display="none";
    document.getElementById("displaychangesbutton").removeAttribute("hidden");
}

// For when the user clicks on the button My Password
function desiredPassword() {
    var displayPassword = document.getElementById("displaypasswordbox");
    
    document.getElementById("changetext").style.display="none";
    document.getElementById("change_password").style.display="none";
    document.getElementById("displaypasswordbox").removeAttribute("hidden");
    document.getElementById("change_email").style.display="none";
    document.getElementById("displaychangesbutton").removeAttribute("hidden");
}
