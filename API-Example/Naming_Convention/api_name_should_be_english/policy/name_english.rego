package main

english_letters := "[A-Za-z]"
digit := "[0-9][A-Za-z]*[0-9]*"

specialchar := "[!-~][A-Za-z]*[!-~]*"

deny[msg]{
    name := input.name
    name == ""
    msg := "Title should not be empty"
}

# deny[msg]{
#     name := input.name
#     decision2 := regex.match(digit, name)
#     decision2 == true
#     msg := "Title should contain only english letters only"
# }

deny[msg]{
    name := input.name
    decision2 := regex.match(specialchar, name)
    decision2 == true
    decision3 := regex.match(digit, name)
    decision3 == 
    decision1 := regex.match(english_letters, name)
    decision1 == false
    msg := "Title should contain only english letters only"
}
