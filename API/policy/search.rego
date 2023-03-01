package search

allow[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    #print(findbystatus)
    find := findbystatus.parameters[_]
    #print(find)
    type := find.schema.type
    type == "string"
    msg := "Type should be string"
}

