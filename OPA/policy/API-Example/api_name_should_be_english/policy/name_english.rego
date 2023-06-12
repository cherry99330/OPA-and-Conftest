# opa eval --format pretty --data policy/name_english.rego -i input.json data.main.deny
package main

english_letters := "^[A-Za-z0-9\\s_]+$"

deny[msg] {
	name := input.info.title
	is_match := regex.match(english_letters, name)

	is_match == false
	msg := "Title should contain english letters only"
}
