package main

import input 

deny[msg]{
    findbystatus := input.paths["/pet/findByStatus"].get
    find := findbystatus.parameters[_]
    type := find.schema.new
    type != "NEW"
    msg := "Schema should be NEW one"
}

deny[msg]{
  apititle := input.info
  title := apititle.title
  not endswith(title, "API")
  msg:= "Title should end with API Suffix"
}


exception[rules] {
    findbystatus := input.paths["/pet/findByStatus"].get
    find := findbystatus.parameters[_]
    type := find.schema.type
    type == "string"

  rules := [""]
}