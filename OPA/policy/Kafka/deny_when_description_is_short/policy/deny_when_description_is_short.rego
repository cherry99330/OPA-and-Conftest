package deny_when_description_is_short

deny[msg] {
	parameters := input.parameters
	some i
	parameters[i]
	count(parameters[i].description) < 20
	msg := sprintf("Description provided is short %v ", [parameters[i].description])
}
