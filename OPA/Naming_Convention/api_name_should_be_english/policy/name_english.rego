package main

#english_letters := "[A-Za-z]"
#digit := "[0-9][A-Za-z]*[0-9]*"

digit := "^[A-Za-z0-9\\s]*$"
# deny[msg]{
#     name := input.name
#     name == ""
#     msg := "Title should not be empty"
# }

deny[msg]{
    name := input.name
    decision2 := regex.match(digit, name)
    decision2 == false
    msg := "Title should contain only english letters only"
}
