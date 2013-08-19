Sub readpath()
	const HKEY_CURRENT_USER = &H80000001
	const HKEY_LOCAL_MACHINE = &H80000002
	strComputer = "."
	Set StdOut = WScript.StdOut
	 
	Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_
	 strComputer & "\root\default:StdRegProv")
	 
	strKeyPath = "SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV"
	strValueName = "Installfolder"
	oReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
	inputpath = strValue
End sub