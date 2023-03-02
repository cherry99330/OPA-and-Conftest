package main

deny[msg]{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  #print(title)
  not endswith(title, "API")
  msg := "Title should end with API"
}

