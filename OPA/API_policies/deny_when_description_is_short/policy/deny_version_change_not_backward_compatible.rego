package ensure_version_change_backward_compatibility

import future.keywords.contains
import future.keywords.in
import future.keywords.if

default update_all := {0:"major", 1:"minor",2:"patch"}
default major_failure := ["minor","patch"]

#patch update
patch_modification contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
	changes:=[[concat(".",a[0]),a[1],b[1]] | walk(data.oldversion,a); walk(input,b); a[0][count(a[0])-1] in ["description","summary","url"]; a[0]==b[0];a[1]!=b[1]]
    some modification in changes
    msg := sprintf("Modification happened at = %v. This is a patch change",[modification[0]])
    path = split(modification[0],".")
   message := {"msg":msg, "path":path}
}

patch_addition contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
	addition_new := [[concat(".",a[0])] | walk(input,a); a[0][count(a[0])-1] in ["description","summary","url"]; count([1| walk(data.oldversion,b); a[0]==b[0]])==0]
    some modification in addition_new
    msg := sprintf("Added parameter(summary/description/url) at position - %v.  This is a patch change",[modification[0]])
    path = split(modification[0],".")
   message := {"msg":msg, "path":path}
}

patch_removal contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
	removed_new := [[concat(".",a[0])] | walk(data.oldversion,a); a[0][count(a[0])-1] in ["description","summary","url"]; count([1| walk(input,b); a[0]==b[0]])==0]
    some modification in removed_new
    msg := sprintf("removed parameter(summary/description/url) at position - %v.  This is a patch change",[modification[0]])
    path = split(modification[0],".")
    policy_path = array.slice(path, 0, count(path)-1)
   message := {"msg":msg, "path":policy_path}
}

#####################################################################################

backward_compatible_endpoint_add contains message if {
    count(object.keys(input.paths)) > count(object.keys(data.oldversion.paths))
    some i in object.keys(input.paths)
    not(i in object.keys(data.oldversion.paths))
    msg := sprintf("Addition of endpoint - %v is an backward compatible change", [i])
    path = ["paths",[i][0]]
   message := {"msg":msg, "path":path}
}

backward_compatible_parameter_add contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    
	input_request_body := [[concat(".",[concat(".",a[0]),"parameters"]),(a[1].parameters)] | walk(input,a); is_object(a[1])]
    data_request_body := [[concat(".",[concat(".",a[0]),"parameters"]),(a[1].parameters)] | walk(data.oldversion,a); is_object(a[1])]
	some i
	path_input = input_request_body[i][0]  
    value_input = input_request_body[i][1]
    path_data = data_request_body[i][0]
    value_data = data_request_body[i][1]
	names_input = [a["name"] | value_input[_]=a]
    names_data = [a["name"] | value_data[_]=a]
	count(names_input)>count(names_data)
    msg := sprintf("New parameter has been added in path = %v",[path_input])
    path = split(path_input,".")
   message := {"msg":msg, "path":path}
}

backward_compatible_parameter_removal contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    
    input_request_body := [[concat(".",[concat(".",a[0]),"parameters"]),(a[1].parameters)] | walk(input,a); is_object(a[1])]
    data_request_body := [[concat(".",[concat(".",a[0]),"parameters"]),(a[1].parameters)] | walk(data.oldversion,a); is_object(a[1])]
	some i
	path_input = input_request_body[i][0]  
    value_input = input_request_body[i][1]
    path_data = data_request_body[i][0]
    value_data = data_request_body[i][1]
	names_input = [a["name"] | value_input[_]=a]
    names_data = [a["name"] | value_data[_]=a]
	count(names_input)<count(names_data)
    msg := sprintf("A parameter has been removed in path = %v",[path_input])
    path = split(path_input,".")
   message := {"msg":msg, "path":path}
}

backward_compatible_request_body_removal contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_request_body := [[concat(".",[concat(".",a[0]),"content"]),(a[1].content)] | walk(input,a); is_object(a[1])]
    data_request_body := [[concat(".",[concat(".",a[0]),"content"]),(a[1].content)] | walk(data.oldversion,a); is_object(a[1])]
    some item
    count(input_request_body[item][1]) < count(data_request_body[item][1])
    msg := sprintf("Removal of a  parameter in the content of request body - %v.This is an backward compatible change",[input_request_body[item][0]])
    policy_path = split(input_request_body[item][0],".")
   message := {"msg":msg, "path":policy_path}
}

backward_compatible_response_addition contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_response_body := [[concat(".",[concat(".",a[0]),"responses"]),(a[1].responses)] | walk(input,a); is_object(a[1])]
    data_response_body := [[concat(".",[concat(".",a[0]),"responses"]),(a[1].responses)] | walk(data.oldversion,a); is_object(a[1])]
    some item
    count(input_response_body[item][1]) > count(data_response_body[item][1])
    msg := sprintf("Additon of a required parameter in the content of response body - %v.This is an  compatible change",[input_response_body[item][0]])
    policy_path = split(input_response_body[item][0],".")
   message := {"msg":msg, "path":policy_path}
}

########################################################################
backward_incompatible_endpoint_modification contains message if {
    count(object.keys(input.paths)) <= count(object.keys(data.oldversion.paths))
    some i in object.keys(data.oldversion.paths)
    not(i in object.keys(input.paths))
    msg := sprintf("Removal/modification of endpoint - %v is an incompatible change", [i])
    path = ["paths"]
    message := {"msg":msg, "path":path}
}

backward_incompatible_parameter_modification contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    
    input_request_body := [[concat(".",[concat(".",input_param[0]),"parameters"]),(input_param[1].parameters)] | walk(input,input_param); is_object(input_param[1])]
    data_request_body := [[concat(".",[concat(".",data_param[0]),"parameters"]),(data_param[1].parameters)] | walk(data.oldversion,data_param); is_object(data_param[1])]

	some i
	path_input = input_request_body[i][0]  
    value_input = input_request_body[i][1]
    path_data = data_request_body[i][0]
    value_data = data_request_body[i][1]
    dict_input = {key["name"]:key | value_input[_]=key}
    dict_data = {key["name"]:key | value_data[_]=key}
	names = [key["name"] | value_input[_]=key]
    some j in names
 	changes:=[[concat(".",a[0]),a[1],b[1]] | walk(dict_input[j],a); walk(dict_data[j],b); a[0][count(a[0])-1] in ["name","in","required","description","format","type"]; a[0]==b[0];a[1]!=b[1]]
       some modification in changes
	
    msg := sprintf("Updating a parameter = %v, at block =%v at location =%v which is an incompatible change",[modification[0],j,path_input])
    path = split(path_input,".")
   message := {"msg":msg, "path":path}
}
backward_incompatible_request_body_modification contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_request_body := [[concat(".",[concat(".",request_input[0]),"content"]),(request_input[1].content)] | walk(input,request_input); is_object(request_input[1])]
    data_request_body := [[concat(".",[concat(".",request_data[0]),"content"]),(request_data[1].content)] | walk(data.oldversion,request_data); is_object(request_data[1])]
    some item
    count(input_request_body[item][1]) == count(data_request_body[item][1])
    input_request_body[item][value]!=data_request_body[item][value]
    msg := sprintf("Modification of a parameter in the content of request body - %v.This is an incompatible change",[input_request_body[item][0]])
    policy_path = split(input_request_body[item][0],".")
    message := {"msg":msg, "path":policy_path}
}

backward_incompatible_request_body_add contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_request_body := [[concat(".",[concat(".",request_input[0]),"content"]),(request_input[1].content)] | walk(input,request_input); is_object(request_input[1])]
    data_request_body := [[concat(".",[concat(".",request_data[0]),"content"]),(request_data[1].content)] | walk(data.oldversion,request_data); is_object(request_data[1])]
    some item
    count(input_request_body[item][1]) > count(data_request_body[item][1])
    msg := sprintf("Additon of a required parameter in the content of request body - %v.This is an  incompatible change",[input_request_body[item][0]])
    policy_path = split(input_request_body[item][0],".")
    message := {"msg":msg, "path":policy_path}
}

backward_incompatible_response_modification contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_response_body := [[concat(".",[concat(".",response_input[0]),"responses"]),(response_input[1].responses)] | walk(input,response_input); is_object(response_input[1])]
    data_response_body := [[concat(".",[concat(".",response_data[0]),"responses"]),(response_data[1].responses)] | walk(data.oldversion,response_data); is_object(response_data[1])]
    some item
    count(input_response_body[item][1]) == count(data_response_body[item][1])
    input_response_body[item][value]!=data_response_body[item][value]
    msg := sprintf("Modification in the responses object - %v.This is an incompatible change",[input_response_body[item][0]])
    policy_path = split(input_response_body[item][0],".")
    message := {"msg":msg, "path":policy_path}
}

backward_incompatible_response_removal contains message if {
    object.keys(input.paths) == object.keys(data.oldversion.paths)
    input_response_body := [[concat(".",[concat(".",response_input[0]),"responses"]),(response_input[1].responses)] | walk(input,response_input); is_object(response_input[1])]
    data_response_body := [[concat(".",[concat(".",response_data[0]),"responses"]),(response_data[1].responses)] | walk(data.oldversion,response_data); is_object(response_data[1])]
    some item
    count(input_response_body[item][1]) < count(data_response_body[item][1])
    input_response_body[item][value]!=data_response_body[item][value]
    msg := sprintf("Removal in the responses object - %v.This is an incompatible change",[input_response_body[item][0]])
    policy_path = split(input_response_body[item][0],".")
    message := {"msg":msg, "path":policy_path}
}
##################################################################################S
major_version_update contains message{
  count(deny_version)==0
  some change in major_failure
  change in version
  major_change := [backward_incompatible_endpoint_modification,backward_incompatible_parameter_modification,backward_incompatible_request_body_modification,backward_incompatible_request_body_add,backward_incompatible_response_modification,backward_incompatible_response_removal]
  some i
  major_change[i] != set()
  some item in major_change[i]
  msg := sprintf("%v not %v change",[item["msg"],change])
  path = item["path"]
  message := {"msg":msg, "path":path}
}

minor_version_update contains message{
  count(deny_version)==0
  count(major_version_update)==0
  "patch" in version
  minor_change := [backward_compatible_endpoint_add,backward_compatible_parameter_add,backward_compatible_parameter_removal,backward_compatible_request_body_removal,backward_compatible_response_addition]
  some i
  minor_change[i] != set()
  some item in minor_change[i]
  msg := sprintf("%v not patch change",[item["msg"]])
  path = item["path"]
  message := {"msg":msg, "path":path}
}

patch_version_update contains message{
  count(deny_version)==0
  count(minor_version_update)==0
  "minor" in version
  patch_change := [patch_modification,patch_addition,patch_removal]
  some i
  patch_change[i] != set()
  some item in patch_change[i]
  msg := sprintf("%v not minor change",[item["msg"]])
  path = item["path"]
  message := {"msg":msg, "path":path}
}

version contains msg if {
    version_old = data.oldversion.info.version
    ver_old := split(version_old,".")
    version_new = input.info.version
    ver_new = split(version_new,".")
    some update in object.keys(update_all)
 	  to_number(ver_new[update])==(to_number(ver_old[update])+1)
    msg := sprintf("%v",[update_all[update]])
}

deny_version contains message{
    count(deny_old_file_not_present)==0
  count(version)!=1
  version_old = data.oldversion.info.version
  version_new = input.info.version
  msg := sprintf("Old version = %v and new version =%v are same or there is a gap in versioning present.",[version_old,version_new])
  policy_path = ["info","version"]
  message := {"msg":msg, "path":policy_path}
}

deny_old_file_not_present contains msg{
  not data.oldversion
  msg := ("Old API file not given which is needed for version backward compatibility check. Please provide the old api file in format as - { \"oldversion\" : <old api file content> } and use -d=\"<old_api_path>\" which running the command.")
}

deny_desired_change contains message{
    count(deny_version)==0
    change := [major_version_update,minor_version_update,patch_version_update]
    some i
    change[i] != set()
    some item in change[i]
    msg := sprintf("%v",[item["msg"]])
    path = item["path"]
    message := {"msg":msg, "path":path}
}

warn_backward_compatible_major contains message{
  count(deny_version)==0
  "major" in version
  change := [patch_modification,patch_addition,patch_removal,backward_compatible_endpoint_add,backward_compatible_parameter_add,backward_compatible_parameter_removal,backward_compatible_request_body_removal,backward_compatible_response_addition]
  some i
  change[i] != set()
  some item in change[i]
  msg := sprintf("%v",[item["msg"]])
  path = item["path"]
  message := {"msg":msg, "path":path}
}