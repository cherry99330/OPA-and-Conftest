package main

import input 

deny[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    find := findbystatus.parameters[_]
    type := find.schema.type
    type != "string"
    msg := "Schema type should be string"
}

