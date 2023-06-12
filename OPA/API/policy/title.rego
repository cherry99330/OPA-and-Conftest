package title

deny[msg] {
	apititle := input.info
	title := apititle.title
	endswith(title, "API")
	msg := "Name should ends with suffix API"
}
