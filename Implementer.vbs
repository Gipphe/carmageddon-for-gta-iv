
' ----- ExeScript Options Begin -----
' ScriptType: window,activescript,invoker
' DestDirectory: temp
' Icon: 
' OutputFile: C:\Users\Victor\Dropbox\My Works\Mods\Carmageddon\Implementer.exe
' CompanyName: Giphtworks
' FileVersion: 2.0.0.0
' LegalCopyright: Giphtworks
' ProductName: Carmageddon
' ProductVersion: 2.0.0.0
' ----- ExeScript Options End -----

Option Explicit

Dim objFSO, config, sContinue, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, cmpath, handlingpath, backuppath, objConfig, objFile, i, strLine
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
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"
Else
	datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it. " ) + "\common\data\"
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
		Exit do
	Else
			sContinue = MsgBox("Could not find handling.dat from the path you specified. Are you sure you wrote it correctly? Code: 11" & _ 
			vbCrLf & "Would you like to try writing it again?", 260, "Could not find file") 
		If sContinue <> 7 Then
			datapath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it. Core: 12" ) & "\common\data\"
			handlingpath = datapath & "handling.dat"
			backuppath = datapath & "backup\handling.dat"
			cmpath = datapath & "cm\handling.dat"
		
			Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
			objConfig.WriteLine(datapath)
			objConfig.Close
		Else if		sContinue <> 6 Then
			sContinue = MsgBox("Carmageddon mod will not work properly otherwise. Are you sure?", 260, "Are you sure you want to exit?") 
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
		End if
		End if
		End If 
		End if
		End if
Loop

cmfolder = datapath & "cm"
backupfolder = datapath & "backup"

If not objFSO.FolderExists(cmfolder) Then
	objFSO.CreateFolder(cmfolder)
	If not objFSO.FolderExists(cmfolder) Then
	wscript.echo "Could not create cmfolder."
	End if
End If
If not objFSO.FolderExists(backupfolder) Then
	objFSO.CreateFolder(backupfolder)
	If not objFSO.FolderExists(Backupfolder) Then
	wscript.echo "Could not create backupfolder."
	End if
End if

If objFSO.FolderExists(cmfolder) Then
	objFSO.CopyFile "handling_carmageddon.dat", cmpath
End If
