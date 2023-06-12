package deny_when_description_is_not_present

deny[msg] {
	parameters := input.parameters
	some i
	parameters[i]
	not parameters[i].description
	msg := sprintf("%v doesn't have description attribute", [parameters[i]])
}
