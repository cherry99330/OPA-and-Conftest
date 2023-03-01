package title

import input
default decision := false

allow[decision]{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  #print(title)
  endswith(title, "API")
  msg := "Name ends with API"
  decision := {
    "allowed": true,
    "message": msg
  }
}


#opa eval -d title.rego -i openapi.json "data.title.allow"