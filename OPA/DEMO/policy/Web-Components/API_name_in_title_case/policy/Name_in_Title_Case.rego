#Policy to check that API name should be in TitleCase
package NameinTitleCase

deny[msg] {
	name := input.info.title

	#regex.split is used to split the name into a separate words 
	splittingName := regex.split(" ", name)
	some i

	#the below regex expression will check for the word that starts with capital letter and followed by small letters
	validName := regex.match("\\b[A-Z][a-z]*\\b", splittingName[i])
	not validName
	msg := sprintf("The name of the API contains special charecters - %s", [splittingName[i]])
}
