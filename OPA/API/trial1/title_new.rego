package main

deny[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    #print(findbystatus)
    find := findbystatus.parameters[_]
    #print(find)
    type := find.schema.type
    #print(type)
    type == "string"
    msg := "Schema type should be string"
}