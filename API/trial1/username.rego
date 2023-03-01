package main

deny[msg]{
    user := input.components.schemas.Customer.properties["username"]
    msg := "username parameter should not be present"
}

