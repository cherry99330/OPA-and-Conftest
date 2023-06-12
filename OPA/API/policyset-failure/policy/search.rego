package search

policy_name = "CHECK_SCHEMA_TYPE"

deny[msg] {
	findbystatus := input.paths["/pet/findByStatus"].get
	find := findbystatus.parameters[_]
	type := find.schema.type
	type != "string"
	msg := ""
	#msg := sprintf("Schema type is: %s, it should be string", [type])
}
