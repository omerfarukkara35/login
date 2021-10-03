Random, string_lenght, 10, 30

;########################################################
randomString := GenerateRandomString(string_lenght)
download_path = C:\Users\%A_UserName%\AppData\Roaming\%randomString%.txt
pastebin_raw_url = https://textbin.net/raw/3ozzhg1iux

;########################################################

global download_path
global pastebin_raw_url

Gui, tokenValidation: Add, Text, x2 y9 w70 h20 , Token :
Gui, tokenValidation: Add, Edit, x82 y9 w200 h20 vtoken, 
Gui, tokenValidation: Add, Button, x2 y39 w280 h20 gLogin, Login
Gui, tokenValidation: Show, w288 h68, Token-System

return

Login:
Gui, submit, nohide
login_valid := login(pastebin_raw, token)
if(login_valid == true)
{
	MsgBox, logged in
}
else
{
	MsgBox, invalid token
}
return

login(pastebin_raw, token)
{	
	currentLine := 2
	URLDownloadToFile, %pastebin_raw_url%, %download_path%
	FileReadLine, token_list_lenght, %download_path%, 1
	Loop, %token_list_lenght%
	{
		FileReadLine, token_test, %download_path%, %currentLine%
		currentLine := currentLine + 1
		if(token_test == token)
		{
			FileDelete, %download_path%
			return true
		}
	}
	FileDelete, %download_path%
	return false
}

GenerateRandomString(length) {
	characters := "0123456789abcdefghijklmnopqurstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" 
	StringSplit, chars, characters
	Loop, %length%
	{
		Random, rand, 1, 64
		randomS .= chars%rand%
	}
	return randomS
}

GuiClose:
ExitApp