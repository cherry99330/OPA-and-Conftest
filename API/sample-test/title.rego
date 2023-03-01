package title

import input

allow {
	title:= input.info.title
  #print(title)
  endswith(title, "API")
}

#opa test . -v
