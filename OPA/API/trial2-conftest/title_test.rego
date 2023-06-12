package search

test_search_success{
    not deny with input as data.search.success
}

test_search_failure{
    deny with input as data.search.failure
}