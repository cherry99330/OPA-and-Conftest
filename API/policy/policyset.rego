package sample1

import data.title
import data.search

allow[msg]{
    s1:= data.search.allow
    s2:= data.title.allow
    success_msg := [s1,s2]
    #can it be a dict -- what all are allowed?
    #check which function is failing - it should tell
    some i
    msg:=sprintf("Success msg %v",[success_msg[i]])
}

# necessity subpackage?

