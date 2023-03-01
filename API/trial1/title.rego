package main

deny[msg]{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  print(title)
  not endswith(title, "API")
  msg := "Title should end with API"
}

deny[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    #print(findbystatus)
    find := findbystatus.parameters[_]
    #print(find)
    type := find.schema.type
    print(type)
    type != "string"
    msg := "Schema type should be string"
}
