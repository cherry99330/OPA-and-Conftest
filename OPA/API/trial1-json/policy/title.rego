package main

deny[msg]{
  apititle := input.info
  #print(apititle)
  title := apititle.title
  #print(title)
  #filename:= input_file()
  #print(filename)
  not endswith(title, "API")
  msg:= "HI"
  #msg := sprintf("Input filename: %v\n", [input.path])
}

