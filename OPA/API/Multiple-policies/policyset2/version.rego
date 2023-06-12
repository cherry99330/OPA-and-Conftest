package oldpackage.version

policy_name = "CHECK_API_VERSION"
deny[msg]{
    version := input.info.version
    version != "1.0.11"
    msg := sprintf("Version is: %s, it should be 1.0.11", [version])
}