package main

import input 

deny_schema[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    find := findbystatus.parameters[_]
    type := find.schema.new
    type == "NEW"
    msg := "Exception example"
}

exception[rules] {
    findbystatus := input.paths["/pet/findByStatus"].get
    find := findbystatus.parameters[_]
    type := find.schema.type
    type == "string"

  rules := ["schema"]
}