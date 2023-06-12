# opa eval --format pretty --data policy/no_country_identifier.rego -i input.json data.main.deny

package main

import future.keywords.in

# country_identifiers := ["CI001", "CI002", "CI003"]
# https://api.first.org/data/v1/countries

country_data := http.send({
	"method": "get",
	"url": "https://api.first.org/data/v1/countries",
})

country_identifiers[k] {
	some k, v in country_data.body.data
}

deny[msg] {
	title := input.info.title
	some ci in country_identifiers
	contains(title, ci)
	msg := sprintf("Title contains country identifier: %v, hence not valid", [ci])
}
