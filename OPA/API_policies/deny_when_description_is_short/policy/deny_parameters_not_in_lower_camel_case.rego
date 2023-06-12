package camel_case

import future.keywords.contains
import future.keywords.in
import future.keywords.if

deny contains error_msg{
	#Fetching all the places where we have "properties"
	obj_camel_case := [[concat(".",[concat(".",camel_case[0]),"properties"]),object.keys(camel_case[1].properties)] | walk(input,camel_case); is_object(camel_case[1]);"type" in object.keys(camel_case[1]);camel_case[1].type == "object"]
    #Checking if the keys are not in camel case
    prop_not_in_camel_case := [[camel_obj,camel_value] | obj_camel_case[camel_obj][1][camel_value]; not regex.match("^[a-z]+[a-zA-Z0-9]*$",camel_value)]
    count(prop_not_in_camel_case)!=0
    some property in prop_not_in_camel_case
	error_msg := sprintf("In path= '%v', property =%v is not in lower camel case.", [obj_camel_case[property[0]][0],property[1]])
    path = {"msg": error_msg, "path":path}
}