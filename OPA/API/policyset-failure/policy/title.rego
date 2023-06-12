package title

policy_name = "CHECK_TITLE"

deny[msg] {
	apititle := input.info
	title := apititle.title
	not endswith(title, "API")
	msg := ""
	#msg := sprintf("API title :%s must end with suffix API", [title])

}
