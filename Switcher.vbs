Option Explicit
Dim objFSO, config, sContinue, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, cmpath, handlingpath, backuppath, objConfig, objFile, i, strLine, TBOGThandlingpath, TLADhandlingpath, TLADdatapath, TLADcmpath, TLADbackuppath, TLADbackupfolder, TLADcmfolder, TBOGTdatapath, TBOGTbackuppath, TBOGTcmpath, TBOGTbackupfolder, TBOGTcmfolder, inputpath, par1, par3, par4, par5, par6, par7, par8, NotReadRights, strComputer, StdOut, strKeyPath, oReg, strValueName, strValue, KEY_QUERY_VALUE, bHasAccessRight
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set StdOut = WScript.StdOut


Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const HKEY_QUERY_VALUE = &H0001	 
Const HKEY_LOCAL_MACHINE = &H80000002
config = ".\GTAIVpath.ini"
strComputer = "."
Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_ 
strComputer & "\root\default:StdRegProv")
strKeyPath = "SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV"
strValueName = "Installfolder"

'---
'Main

checkregistryaccess
readpath
confirmpath(handlingpath)

scriptrun

'---
'Subroutines

Sub readpath()
	If NotReadRights = 1 then
		findpath
	elseif NotReadRights = 0 then
		oReg.GetStringValue HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
		
		inputpath = strValue
			setpaths
		
		if inputpath = "" then
			findpath
		End if
	else
		wscript.echo "Some really gunky shit happened (an impossible value became possible) and I dunno what the fuck to do! >.< Error code: 42" & _
		vbCrLf & "Nonetheless, I'll try to continue on; I'll notify you if something else's weird."
		findpath		
	End if
End sub

Sub findpath()
	If objFSO.FileExists(config) Then
		Set objFile = objFSO.OpenTextFile(config, ForReading)

		Dim arrFileLines()
		i = 0
		Do Until objFile.AtEndOfStream
		Redim Preserve arrFileLines(i)
		arrFileLines(i) = objFile.ReadLine
		i = i + 1
		Loop
		objFile.Close

		For Each strLine in arrFileLines
		inputpath = strLine
		Next
		setpaths
	Else
		inputpath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files (x86)\Steam\steamapps\common\grand theft auto iv\GTAIV', '(C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it. ",10,"C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV" )
		setpaths
		
		Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
		objConfig.WriteLine(inputpath)
		objConfig.Close
	End if
End sub

Sub setpaths()
	datapath = inputpath & "\common\data\"
	handlingpath = datapath & "handling.dat"
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"

	
	cmfolder = datapath & "cm"
	backupfolder = datapath & "backup"
End sub

Sub confirmpath(par3)
	configfound = 0
	Do until configfound = 1
		If objFSO.FileExists(par3) Then
			configfound = 1
			Exit do
		Else
				sContinue = MsgBox("Could not find handling.dat from the path you specified. Are you sure you wrote it correctly? Code: 11" & _ 
				vbCrLf & "Would you like to try writing it?", 260, "Could not find critical file") 
			If sContinue <> 7 Then
				Call findpath()
			Else if		sContinue <> 6 Then
				sContinue = MsgBox("Carmageddon mod will not work properly otherwise. Are you sure?", 260, "Are you sure you want to exit?") 
				If sContinue <> 7 Then
					wscript.quit()
				Else if sContinue <> 6 Then	
					Call findpath()
				End if
				End if
			End If 
			End if
		End if
	Loop
End sub

Sub scriptrun
	If objFSO.FileExists(backuppath) Then
		If objFSO.FileExists(cmpath) Then
			wscript.echo "Something's wrong: there exists a backup of the original, the carmageddon version AND an active file (which is undefined), all at the same time." & _
			vbCrLf & "Delete either the backup or the carmageddon backup. They can be found in folders in your '\common\data' folder." & _
			vbCrLf & "Check the active file to see which of them it it, and delete the other one."
		else if not objFSO.FileExists(cmpath) Then
			sContinue = MsgBox("Carmageddon is currently active." & _ 
			vbCrLf & "Would you like to deactivate Carmageddon?", 260, "Carmageddon active") 
			If sContinue <> 7 Then
				objFSO.MoveFile handlingpath, cmpath
				objFSO.MoveFile backuppath, handlingpath
				wscript.echo "Carmageddon deactivated."
				wscript.quit()
			Else if		sContinue <> 6 Then
				WScript.Echo "Carmageddon will remain active. Exiting."
				WScript.Quit() 
			End If 
		End if
		End if
		End if
	Else if not objFSO.FileExists(backuppath) Then
		If objFSO.FileExists(cmpath) Then
			sContinue = MsgBox("Carmageddon is currently inactive." & _ 
			vbCrLf & "Would you like to activate Carmageddon?", 260, "Carmageddon inactive") 
			If sContinue <> 7 Then
				objFSO.MoveFile handlingpath, backuppath 
				objFSO.MoveFile cmpath, handlingpath 
				wscript.echo "Carmageddon activated."
				wscript.quit()
			Else if		sContinue <> 6 Then
				WScript.Echo "Carmageddon will remain inactive. Exiting."
				WScript.Quit() 
			End If 
			End if
		Else if not objFSO.FileExists(cmpath) Then
			wscript.echo "Couldn't find neither the original backup nor carmageddon's backup. Something went wrong during the implementation." & _
			vbCrLf & "Try running Implementer.vbs in CarE's installation directory or contact Gipphe for support."
			wscript.quit()
		End if
	End if
	End if
	End if
End sub

Sub checkregistryaccess()
	NotReadRights = 0
	strKeyPath = "SYSTEM\CurrentControlSet"
	 	 
	oReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_QUERY_VALUE, _
		bHasAccessRight
	If bHasAccessRight = False Then
		StdOut.WriteLine "You do not have the necessary rights to read the registry on your computer."
		NotReadRights = 1
	End If   
End sub