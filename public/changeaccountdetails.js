function desiredEmail() {
    var displayEmail = document.getElementById("displayemailbox");
    
    document.getElementById("displayemailbox").removeAttribute("hidden");
    document.getElementById("change_password").style.display="none";
    document.getElementById("displaychangesbutton").removeAttribute("hidden");
}

function desiredPassword() {
    var displayPassword = document.getElementById("displaypasswordbox");
    
    document.getElementById("displaypasswordbox").removeAttribute("hidden");
    document.getElementById("change_email").style.display="none";
    document.getElementById("displaychangesbutton").removeAttribute("hidden");
}
