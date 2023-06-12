Open Policy Agent

OPA is a tool that allows you to define and enforce rules across an organization’s systems, applications,API and infrastructure. It provides a unified way of managing policies and making decisions based on those policies.
OPA was originally created by Styra.
REF:https://www.openpolicyagent.org/docs/latest/

Rego 

Rego is the policy language used by OPA and is designed to provide a simple and readable way to write rules and policies.Rego rules can be written to define the logic for specific policies, such as allowing or denying access to a resource.
REF:https://www.openpolicyagent.org/docs/latest/policy-language/#what-is-rego

Conftest

Conftest is a utility to help you write tests against structured configuration data .Conftest relies on the Rego language from Open Policy Agent for writing policies.
Conftest is designed to be integrated into a CI/CD pipeline, where it can validate configuration files before they are deployed to production.
https://www.conftest.dev/

Examples:

Example 1: This example demostrates how to evaluate policy against a given input.

command used : opa eval
We can use this command to evaluate Rego expressions and policies.
REF:https://www.openpolicyagent.org/docs/latest/cli/#opa-eval

Commonly used flags include: 
    bundle(Load a bundle file or directory into OPA)
    data(Load policy or data files into OPA)
    input(Load a data file and use it as input) 
    format(Set the output format to use)

Note: bundle and data flag can be repeated but we cannot repeat input flag.
When running -  opa eval -d title.rego -i open.json -i openapi.json "data.title.allow", it only reads the last input file.

Example 2: This example demostrates how to test policy in OPA against test cases.

command used : opa test
The opa test subcommand runs all of the tests (i.e., rules prefixed with test_) found in Rego files passed on the command line.

Results we get as output:
PASS: denotes a number of testcases passed out of all
FAIL: denotes a number of testcases failed out of all
SKIPPED: to skip a test case it should start with "todo_" . We will not see the result of this testcase
ERROR: If the test encounters a runtime error the test result is marked as an ERROR

commonly flags used:
. :The 'test' command takes a file or directory path as input and executes all test cases discovered in matching files. Test cases are rules whose names have the prefix "test_".
-v(--verbose ):set verbose reporting mode

When running: opa test . -v
REF:https://www.openpolicyagent.org/docs/latest/policy-testing/#getting-started

Example 3: This example demonstrate how we can use policyset to test multiple policies against input file.

Policyset is a collection of different policies which are tested against a single input file.
To test a policyset:

Folder structure:
    input file
    bundle that contains all policies.
command to run : opa eval -b bundle.tar.gz --input openapi.json "data.sample1.allow"

To create a bundle, run command : opa build -b .\policy\
Above command will create a bundle with default name bundle.tar.gz. If you want to create bundle with custom name, run command : opa build -b --output="<bundlename>" .\policy\

Note : Example 3 prints the message when a policy is passing. But using this example we cannot determine which input is failing.

Example 4:This example demonstrate how we can use policyset to test multiple policies against input file and prints message when policy is failing.

Example 5: This example demonstrate how we can use subpackages to organize and group related policy rules and data together.

folder structure:

main.rego - (imports subpackages from the package1 and package2)
    |-package1
        |-package1.rego (imports subpackages from package folder)
        |-subpackage folder
            |- all the policies created for the package1
    |-package2
        |-package2.rego (imports subpackages from package folder)
        |-subpackage folder
            |- all the policies created for the service2

command to run : opa eval -b .\package.tar.gz -i .\failure.json data.main

Example 6: This example demonstrate how to test policy in Conftest against given input file.

command to run : conftest test -p title.rego openapi.json
REF:https://www.conftest.dev/

Policies by default should be placed in a directory called policy, but this can be overridden with the --policy flag.
By default, Conftest looks for these rules in the main namespace, but this can be overriden with the --namespace flag or provided in the configuration file. To look in all namespaces, use the --all-namespaces flag.
EX: 
conftest test -p title.rego openapi.json --all-namespaces :---to check in all the packages present
conftest test -p title.rego openapi.json -n <package_name> :-- to check in a specific package other than main

Example 7:This example demonstrate how to test multiple policies in Conftest against given input file.

command to run : conftest test openapi.json
Here all the policies under the policy folder are being tested against the input openapi.json
If we use this approach all the policies related to a particular service/api will be in one place. Easy to manage and locate policies as well.

Example 8:This example demonstrate how to verfiy policy against unit test cases

command to run :conftest verify --policy .\title_test.rego --policy .\title.rego --policy .\input.rego 
REF:https://www.conftest.dev/

Example 9:This example demonstrate how to verfiy multiple policies against unit test cases

command to use: conftest verify
When we write conftest verify, it locates policy folder and under that runs test.rego file.

Here as well,Policies by default should be placed in a directory called policy, but this can be overridden with the --policy flag.
To fetch the output in specific format, we can use the flag --output.
https://www.conftest.dev/options/

Example 10: This example demostrates how we can pass multiple inputs to policies by a single run.

command to run : conftest test -p .\policy\ .\input\ --all-namespaces

In this example, all the policies under the folder policy will run against every input file which is under input folder.

Example 11: This example demostrates how we can implement exception policies through conftest.

There might be cases where rules might not apply under certain circumstances. For those occasions, you can use exceptions. Exceptions are also written in rego, and allow you to specify policies for when a given deny or violation rule does not apply.

exception[rules] {
  # Logic

  rules = ["foo","bar"]
}

The above would provide an exception from deny_foo and violation_foo as well as deny_bar and violation_bar.