package main

allow{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  #print(title)
  endswith(title, "API")
}


#opa eval -d title.rego -i openapi.json "data.title.allow"