package ensure_error_schema

import future.keywords.contains
import future.keywords.in
import future.keywords.if

default error_schema := { "4": "link1", "5": "link2"}

deny contains message {
	paths = input.paths

	# from input 
	some path in object.keys(paths)
	some response_type in object.keys(paths[path])
	some response_code in object.keys(paths[path][response_type].responses)
    
	#fetching desired ref schema from the error_schema
    some error_code in object.keys(error_schema)
    error_link := error_schema[error_code]

    # comparison
    regex.match(sprintf("^[%v]+[0-9]+[0-9]$", [error_code]), response_code) 
	response_ref_link := paths[path][response_type].responses[response_code].schema["$ref"]
	response_ref_link != error_link
	msg := sprintf("Ref Link for Path=%v, Response_type=%v, Response_Code=%v, Provided_Link=%v is incorrect", [path, response_type, response_code, response_ref_link])
}






