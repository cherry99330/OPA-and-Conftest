package deny_when_contact_email_not_valid

deny[msg]{
    info := input.info
    email := info.contact.email
    not endswith(email, "@gmail.com")
    msg:=sprintf("Provided email %v is not valid",[email])
}

