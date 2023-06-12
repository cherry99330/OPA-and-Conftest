package search

deny{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  print(title)
  not endswith(title, "API")
  print("Title should end with API")
}
