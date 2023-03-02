package newpackage.all

import data.newpackage.search as search
import data.newpackage.title as title
package_name := "Package 1"
deny[msg]{
    search.deny
    title.deny
    error_msg := [search.deny,title.deny]
	policy_name := [search.policy_name,title.policy_name]
    some i
	msg := sprintf("For policy-%v. Error message is-%v", [policy_name[i], error_msg[i]])
}