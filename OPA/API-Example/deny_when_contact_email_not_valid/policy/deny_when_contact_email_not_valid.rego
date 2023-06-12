package main

import data.oldversion

deny[msg]{
    info := input.info.version
    old := oldversion.info.version
    msg:=sprintf("Old ---%v, new---%v",[old,info])
}

