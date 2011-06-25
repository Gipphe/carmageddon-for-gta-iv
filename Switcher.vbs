
' ----- ExeScript Options Begin -----
' ScriptType: window,activescript,invoker
' DestDirectory: temp
' Icon: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Promo Material\Giphtworks.ico
' OutputFile: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Carmageddon Switcher.exe
' Comments: Activate/Deactivate Carmageddon
' CompanyName: Giphtworks
' FileDescription: Activate/Deactivate Carmageddon
' FileVersion: 2.0.0.0
' LegalCopyright: Giphtworks
' ProductName: Carmageddon
' ProductVersion: 2.0.0.0
' ----- ExeScript Options End -----


Option Explicit
Dim objFSO, objFile, Instdir, demofile, datapath, handlingpath, backuppath, cmpath, objConfig, config, handlingfound, sContinue, i, strLine, Filefound

Const ForReading = 1, ForWriting = 2, ForAppending = 8
config = ".\path.txt"
handlingfound = 0

Set objFSO = CreateObject("Scripting.FileSystemObject")
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
	datapath = strLine
	Next
	handlingpath = datapath & "handling.dat"
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"
Else
	datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." ) + "\common\data\"
	handlingpath = datapath & "handling.dat"
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"
	
	Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
	objConfig.WriteLine(datapath)
	objConfig.Close
End If

Do until filefound = 1
	If objFSO.FileExists(handlingpath) Then
		filefound = 1
	Else
		sContinue = MsgBox("Could not find handling.dat from the path you specified. Are you sure you wrote it correctly?" & _ 
			vbCrLf & "Would you like to try writing it again?", 260, "Could not find file") 
		If sContinue <> 7 Then
			datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." ) + "\common\data\"
			handlingpath = datapath & "handling.dat"
			backuppath = datapath & "\backup\handling.dat"
			cmpath = datapath & "\cm\handling.dat"
		
			Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
			objConfig.WriteLine(datapath)
			objConfig.Close
		Else if		sContinue <> 6 Then
			WScript.Echo "Very well. Exiting."
			WScript.Quit() 
		End If 
	End If
	End if
Loop

'---

If objFSO.FileExists(backuppath) Then
	If objFSO.FileExists(cmpath) Then
		wscript.echo "Something's wrong: there exists a backup, carmageddon backup AND active file, all at the same time. Delete either the backup or the carmageddon backup. They can be found in folders in your '\common\data' folder"
	else
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
Else
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
	Else
		wscript.echo "Couldn't find neither the original backup nor carmageddon's backup. Something went wrong during the installation. Contact the creator."
		wscript.quit()
	End if
End if