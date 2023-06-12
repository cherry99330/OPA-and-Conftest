package main

warn[msg]{
  apititle := input.info
  title := apititle.title
  not endswith(title, "API")
  msg:= "Title should end with suffix API"
}

