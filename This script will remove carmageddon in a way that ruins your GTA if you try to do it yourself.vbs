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
	wscript.Quit()
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
Else	
	wscript.echo "An unexpected error occured. Error code: 2"
	wscript.Quit()
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
'-----------------
'----------
'---
'Start

'Check if instdirC exists
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
	If objFSO.FileExists(instdirC) Then 
		'instdirC exists
		set fso = CreateObject("Scripting.FileSystemObject")
		fso.Deletefile instdirC
		wscript.echo "Carmageddon's file has been deleted. Continuing... Code: 410"
	else
		'instdirC does not exist
				set objFSO = CreateObject("Scripting.FileSystemObject")
				'Check if instdirB exists
					if objFSO.FileExists(instdirB) Then
						'delete handling.dat, which is the carmageddon file
						Set fso = CreateObject("Scripting.FileSystemObject")
						fso.Deletefile instdir
						wscript.echo "Carmageddon's file has been deleted. Continuing... Code: 411"
					else
						wscript.quit()
	end if
	
	set objFSO = CreateObject("Scripting.FileSystemObject")
	'Check if instdirB exists
	if objFSO.FileExists(instdirB) Then
		'instdirB exists
		'Rename instdirB to instdir
			strComputer = "." 
			Set objWMIService = GetObject("winmgmts:" _ 
					& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
		 
			Set colFiles = objWMIService.ExecQuery _ 
					("Select * from Cim_Datafile where Name = " _ 
					& instdirBF) 

			For Each objFile in colFiles 
					errResult = objFile.Rename(instdir) 
					wscript.echo "The original handling.dat file has been reinstated. Code: 412" & errResult
			Next 
	else
		'instdirB doesn't exist
				'moving new handling.dat to the data directory
						set filesys = CreateObject("Scripting.FileSystemObject")
						set demofile = filesys.GetFile("./handling.dat")
						demofile.Move (instdirec)
						wscript.echo "The original handling.dat file has been reinstated. Code: 413"
	end if
	end if