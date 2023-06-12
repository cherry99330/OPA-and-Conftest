package deny_when_info_does_not_have_contact_obj

deny contains msg{
	some i,j
    path:=input.paths[i][j]
    res := path.responses
    some k 
    #msg:=sprintf("%v",[res])
}