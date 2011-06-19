
' ----- ExeScript Options Begin -----
' ScriptType: window,activescript,invoker
' DestDirectory: temp
' Icon: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Giphtworks.ico
' OutputFile: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Carmageddon Switcher.exe
' Comments: Activate/Deactivate Carmageddon
' CompanyName: Giphtworks
' FileDescription: Activate/Deactivate Carmageddon
' FileVersion: 1.7.0.0
' LegalCopyright: Giphtworks
' ProductName: Carmageddon
' ProductVersion: 1.7.0.0
' ----- ExeScript Options End -----


'------------------
'File List
'------------------
	'Active one
	'---
x86R = "C:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling.dat"
x86RF = "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'"
x64R = "C:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling.dat"
x64RF = "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'"
x86S = "C:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling.dat"
x86SF = "'c:\\Progra~1\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling.dat'"
x64S = "C:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling.dat"
x64SF = "'c:\\Progra~2\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling.dat'"
	'---
	'Carmageddon switcher
	'---
x86RC = "C:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat"
x86RFC = "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_carmageddon.dat'"
x64RC = "C:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat"
x64RFC = "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_carmageddon.dat'"
x86SC = "C:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat"
x86SFC = "'c:\\Progra~1\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_carmageddon.dat'"
x64SC = "C:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat"
x64SFC = "'c:\\Progra~2\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_carmageddon.dat'"
	'---
	'Backup
	'---
x86RB = "C:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat"
x86RFB = "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_backup.dat'"
x64RB = "C:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat"
x64RFB = "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_backup.dat'"
x86SB = "C:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_backup.dat"
x86SFB = "'c:\\Progra~1\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_backup.dat'"
x64SB = "C:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_backup.dat"
x64SFB = "'c:\\Progra~2\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_backup.dat'"
'-------------------------
'Find istall directory
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(x86R) Then 
	insttype = "x86R"
ElseIf objFSO.FileExists(x64R) Then
	insttype = "x64R"
ElseIf objFSO.FileExists(x86S) Then
	insttype = "x86S"
ElseIf objFSO.FileExists(x64S) Then
	insttype = "x64S"
Else
	wscript.echo "Not found. Error code: 1"
	insttype = "not"
End If

'-------------------------
'Set install path
if insttype = "x86R" then
	instdirec = "C:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\"
elseif insttype = "x64R" then
	instdirec = "C:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\"
elseif insttype = "x86S" then
	instdirec = "C:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\"
elseif insttype = "x64S" then
	instdirec = "C:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\"
elseif insttype = "not" then
	wscript.echo "You do not have GTA IV installed. Error code: 20" 
else
	wscript.echo "Something unexpected happened... Error code: 21"
end if

'-------------------------
'Set install directory
if insttype = "x86R" then
	instdir = x86R
Elseif insttype = "x64R" then
	instdir = x64R
Elseif insttype = "x86S" then
	instdir = x86S
Elseif insttype = "x64S" then	
	instdir = x64S
Elseif insttype = "not" then
	wscript.echo "You do not have GTA IV installed."
	wscript.quit()
Else	
	wscript.echo "An unexpected error occured. Error code: 2"
	wscript.quit()
End If
'-------------------------
'Set fucked install directory
if instdir = x86R then
	instdirF = x86RF
Elseif instdir = x64R then
	instdirF = x64RF
elseif instdir = x86S then
	instdirF = x86SF
elseif instdir = x64S then
	instdirF = x64SF
else
	wscript.echo "An unexpected error occured. Error code: 3"
	wscript.quit()
End if
'-------------------------
'Set carmageddon path
if instdir = x86R then
	instdirC = x86RC
elseif instdir = x64R then
	instdirC = x64RC
elseif instdir = x86S then
	instdirC = x86SC
elseif instdir = x64S then
	instdirC = x64SC
else
	wscript.echo "An unexpected error occured. Error code: 4"
	wscript.quit()
End if
'-------------------------
'Set fucked carmageddon path
if instdir = x86R then
	instdirCF = x86RFC
elseif instdir = x64R then
	instdirCF = x64RFC
elseif instdir = x86S then
	instdirCF = x86SFC
elseif instdir = x64S then
	instdirCF = x64SFC
else
	wscript.echo "An unexpected error occured. Error code: 5"
	wscript.quit()
end if
'-------------------------
'Set backup path
if instdir = x86R then
	instdirB = x86RB
elseif instdir = x64R then
	instdirB = x64RB
elseif instdir = x86S then
	instdirB = x86SB
elseif instdir = x64S then
	instdirB = x64SB
else
	wscript.echo "An unexpected error occurred. Error code: 6"
	wscript.quit()
end if
'-------------------------
'Set fucked backup path
if instdir = x86R then
	instdirBF = x86RFB
elseif instdir = x64R then
	instdirBF = x64RFB
elseif instdir = x86S then
	instdirBF = x86SFB
elseif instdir = x64S then
	instdirBF = x64SFB
else
	wscript.echo "An unexpected error occurred. Error code: 7"
	wscript.quit()
end if
'-------------------------
'Choice to activate Carmageddon
intanswer = _
	MsgBox("Welcome to the Carmageddon Switcher." & _ 
    vbCrLf & "Click 'Yes' to activate Carmageddon, and 'No' to deactivate Carmageddon.", _
		vbYesNo, "Carmageddon Switcher")
	If intanswer = vbYes then
		wScript.Echo "Activating Carmageddon."
		activeCheck instdirB
		movefileOut1 instdirF,instdirB
'		movefileOut2 instdirB
		movefileIn1 instdirCF,instdir
'		movefileIn2 instdir
		wscript.echo "Carmageddon sucessfully activated."
		wScript.Quit()
	Else
		WScript.Echo "Deactivating Carmageddon." 
		deactiveCheck instdirC
		movefileOut1 instdirF,instdirC
'		movefileOut2 instdirC
		movefileIn1 instdirBF,instdir
'		movefileIn2 instdir 
		wscript.echo "Carmageddon sucessfully deactivated."
		WScript.Quit() 
	End If 




'-------------------------
'MovefileIn
	Sub movefileIn1(tel,til)
		strComputer = "." 
		Set objWMIService = GetObject("winmgmts:" _ 
				& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
	 
		Set colFiles = objWMIService.ExecQuery _ 
				("Select * from Cim_Datafile where Name = " _ 
				& tel) 
'	 end sub
'	 sub movefileIn(til)
		For Each objFile in colFiles 
				errResult = objFile.Rename(til) 
				Wscript.Echo "File moved into tray. Code: " & errResult 
		Next 
	End sub
'-------------------------
'MovefileOut
	Sub movefileOut1(tol,tal)
		strComputer = "." 
		Set objWMIService = GetObject("winmgmts:" _ 
				& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
	 
		Set colFiles = objWMIService.ExecQuery _ 
				("Select * from Cim_Datafile where Name = " _ 
				& tol) 
'	end sub
'	sub movefileOut2(tal)
		For Each objFile in colFiles 
				errResult = objFile.Rename(tal) 
				Wscript.Echo "File moved out of tray. Code: " & errResult 
		Next 
	End sub
'-------------------------
'Check if already deactivated
sub deactiveCheck(par6)
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
	If objFSO.FileExists(par6) Then 
    		Set objFolder = objFSO.GetFile(par6) 
    		Wscript.Echo "You have already deactivated carmageddon. Exiting."
        	wScript.Quit()
	end if
end sub
'-------------------------
'Check if already activated
sub activeCheck(par7)
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
	If objFSO.FileExists(par7) Then 
    		Set objFolder = objFSO.GetFile(par7) 
    		Wscript.Echo "You have already activated carmageddon. Exiting."
        	wScript.Quit()
	end if
end sub