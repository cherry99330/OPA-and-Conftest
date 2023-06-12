package oldpackage.all

import data.oldpackage.version as version

package_name := "Package 2"
deny[msg]{
    version.deny
    error_msg := [version.deny]
	policy_name := [version.policy_name]
    some i
	msg := sprintf("For policy-%v. Error message is-%v", [policy_name[i], error_msg[i]])
}