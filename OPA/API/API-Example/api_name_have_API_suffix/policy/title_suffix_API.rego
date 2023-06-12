# opa eval --format pretty --data policy/title_suffix_API.rego -i input.json data.main.deny
# use contains instead of [msg]
package main

deny[msg] {
	api_title
}

api_title contains msg{
	name := input.info.title
	endswith(name, "API") == false
	msg := "Title should end with API"
}