package deny_when_description_is_short

test_missing_parameter_description_fails {
	deny[msg] with input as failure
}

test_existing_parameter_description_succeeds {
	count(deny) == 0 with input as success
}

failure := {
  "parameters": [
    {
      "name": "pet",
      "description": "Everything",
      "externalDocs": {
        "description": "Find out more",
        "url": "http://swagger.io"
      }
    },
    {
      "name": "store",
      "description": "Everything",
      "externalDocs": {
        "description": "Find out more about our store",
        "url": "http://swagger.io"
      }
    },
    {
      "name": "user",
      "description": "Operations"
    }
  ]
}
success := {
  "parameters": [
    {
      "name": "pet",
      "description": "Everything about your Pets iewsgblksBJDGipe aksbf;kah",
      "externalDocs": {
        "description": "Find out more",
        "url": "http://swagger.io"
      }
    },
    {
      "name": "store",
      "description": "Access to Petstore orders vuysdvfjsb eiufblkajb",
      "externalDocs": {
        "description": "Find out more about our store",
        "url": "http://swagger.io"
      }
    },
    {
      "name": "user",
      "description": "Operations about user qipwubfkajsfn ;asojebfAOInFMASL,F L"
    }
  ]
}
