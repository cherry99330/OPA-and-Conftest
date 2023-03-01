package title

allow[msg]{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  #print(title)
  endswith(title, "API")
  msg := "Name should ends with suffix API"
}

