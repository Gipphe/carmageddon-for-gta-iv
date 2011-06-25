
' ----- ExeScript Options Begin -----
' ScriptType: window,activescript,invoker
' DestDirectory: temp
' Icon: 
' OutputFile: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Reinstatement.exe
' CompanyName: Giphtworks
' FileVersion: 2.0.0.0
' LegalCopyright: Giphtworks
' ProductName: Carmageddon
' ProductVersion: 2.0.0.0
' ----- ExeScript Options End -----

Option Explicit

Dim objFSO, config, sContinue, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, FilesFound, cmpath, handlingpath, objFile, i, strLine, filefound, backuppath, delefolder
Set objFSO = CreateObject("Scripting.FileSystemObject")

Const ForReading = 1, ForWriting = 2, ForAppending = 8
config = ".\path.txt"
configfound = 0

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
	backuppath = datapath & "\backup\handling.dat"
	cmpath = datapath & "\cm\handling.dat"
Else
	datapath = inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." ) + "\common\data\"
	handlingpath = datapath & "handling.dat"
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"
	
	Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
	objConfig.WriteLine(datapath)
	objConfig.Close
End if

Do until configfound = 1
	If objFSO.FileExists(handlingpath) Then
		configfound = 1
		If configfound = 1 Then Exit Do
	Else
			sContinue = MsgBox("Could not find handling.dat from the path you specified. Are you sure you wrote it correctly?" & _ 
			vbCrLf & "Would you like to try writing it again?", 260, "Could not find file") 
		If sContinue <> 7 Then
			datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." ) + "\common\data\"
			handlingpath = datapath & "handling.dat"
			backuppath = datapath & "backup\handling.dat"
			cmpath = datapath & "cm\handling.dat"
		
			Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
			objConfig.WriteLine(datapath)
			objConfig.Close
		Else if		sContinue <> 6 Then
			sContinue = MsgBox("Carmageddon mod will not be uninstalled properly otherwise. Are you sure?", 260, "Are you sure you want to exit?") 
			If sContinue <> 7 Then
				wscript.quit()
			Else if sContinue <> 6 Then	
			datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." ) + "\common\data\"
			handlingpath = datapath & "handling.dat"
			backuppath = datapath & "backup\handling.dat"
			cmpath = datapath & "cm\handling.dat"
		
			Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
			objConfig.WriteLine(datapath)
			objConfig.Close
		End If 
	End if
	End if
	End if
	End if
Loop

If objFSO.FileExists(cmpath) Then
	objFSO.DeleteFile cmpath, True
	FilesFound = 1
End if

If objFSO.FileExists(backuppath) Then
	objFSO.DeleteFile handlingpath, True
	objFSO.MoveFile backuppath, handlingpath
	FilesFound = 1
End if

if FilesFound = 0 Then
	If objFSO.FileExists(handlingpath) Then
		objFSO.DeleteFile handlingpath, True
		objFSO.CopyFile ".\handling.dat", handlingpath
	Else
		objFSO.CopyFile ".\handling.dat", handlingpath
	End if
End if

cmfolder = datapath & "cm\"
backupfolder = datapath & "backup\"

If objFSO.FolderExists(cmfolder) Then
	set delefolder = objFSO.GetFolder(cmfolder)
	delefolder.Delete
End if
If objFSO.FolderExists(backupfolder) Then
	set delefolder = objFSO.GetFolder(backupfolder)
	delefolder.Delete
End if	