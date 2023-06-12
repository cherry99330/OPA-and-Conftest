package deny_when_description_is_not_present

# test_mock := false

# test
test_missing_parameter_description_fails {
	deny[msg] with input as failure
}

test_existing_parameter_description_succeeds {
	count(deny) == 0 with input as success
}

failure := {"parameters": [
	{
		"name": "pet",
		"externalDocs": {
			"description": "Find out more",
			"url": "http://swagger.io",
		},
	},
	{
		"name": "store",
		"externalDocs": {
			"description": "Find out more about our store",
			"url": "http://swagger.io",
		},
	},
	{
		"name": "user",
		"description": "Operations about user",
	},
]}

success := {"parameters": [
	{
		"name": "pet",
		"description": "Everything about your Pets",
		"externalDocs": {
			"description": "Find out more",
			"url": "http://swagger.io",
		},
	},
	{
		"name": "store",
		"description": "Access to Petstore orders",
		"externalDocs": {
			"description": "Find out more about our store",
			"url": "http://swagger.io",
		},
	},
	{
		"name": "user",
		"description": "Operations about user",
	},
]}
