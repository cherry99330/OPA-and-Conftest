package main

deny[msg]{
  apititle := input.info
  title := apititle.title
  not endswith(title, "API")
  msg:= "Title should end with API Suffix"
}

