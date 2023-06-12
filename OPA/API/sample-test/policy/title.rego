package example

default allow = false

allow {
    input.path = ["users", user_id, "groups"]
    input.groups[_] = "admin"
}

user_id = input.user_id
