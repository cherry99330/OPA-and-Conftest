package sample1

import data.search
import data.title

# deny[msg]{
#     s1:= data.search.allow
#     s2:= data.title.allow
#     success_msg := [s1,s2]
#     #can it be a dict -- what all are allowed?
#     #check which function is failing - it should tell
#     some i
#     msg:=sprintf("Success msg %v",[success_msg[i]])
# }

# necessity subpackage?

deny[msg] {
	data.search.deny
	data.title.deny
	data.title.allow
	error_msg := [data.search.deny, data.title.deny, data.title.allow]
	policy_name := [data.search.policy_name, data.title.policy_name, data.title.policy_name]

	#some i
	# msg := sprintf("For policy-%v. Error message is-%v", [policy_name[i], error_msg[i]])
	msg := ""
}
