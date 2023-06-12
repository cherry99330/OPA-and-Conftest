#Policy to check that API name should not contain Special Charecters 
package NameShlouldNotContainSpecialCharecters

deny[msg] {
	name := input.info.title

	#Declared a variable and storing the special charecters
	special_chars := "[!@#$%^&*()_+\\-={}\\[\\]|;:\"<>,.?/~`]"
	validname := regex.match(special_chars, name)
	validname
	msg := sprintf("The name of the API contains special charecters - %s", [name])
}
