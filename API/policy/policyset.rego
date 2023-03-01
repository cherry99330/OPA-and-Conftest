package sample1

import data.title
import data.search

allow[msg]{
    data.search.allow
    data.title.allow
    success_msg := [data.search.allow,data.title.allow]
    some i
    msg:=sprintf("Success msg %v",[success_msg[i]])
}


