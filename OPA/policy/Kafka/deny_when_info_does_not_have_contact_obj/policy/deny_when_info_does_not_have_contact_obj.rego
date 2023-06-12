package deny_when_info_does_not_have_contact_obj

deny[msg] {
	info := input.info
	not info.contact
	msg := sprintf("%v doesn't have contact attribute", [info])
}
