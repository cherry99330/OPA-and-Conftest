package main

import data.newpackage.all as new
import data.oldpackage.all as old

deny[msg]{
    package_name_all := [new.package_name,old.package_name]
    some i
    msg := sprintf("packages imported %v", [package_name_all[i]])
}