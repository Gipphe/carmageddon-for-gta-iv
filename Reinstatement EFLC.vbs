
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

Dim objFSO, config, sContinue, FilesFound, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, cmpath, delefolder, handlingpath, backuppath, objConfig, objFile, i, strLine, TBOGThandlingpath, TLADhandlingpath, TLADdatapath, TLADcmpath, TLADbackuppath, TLADbackupfolder, TLADcmfolder, TBOGTdatapath, TBOGTbackuppath, TBOGTcmpath, TBOGTbackupfolder, TBOGTcmfolder, inputpath, par1, par3, par4, par5, par6, par7, par8
Set objFSO = CreateObject("Scripting.FileSystemObject")

Const ForReading = 1, ForWriting = 2, ForAppending = 8
config = ".\EFLCpath.txt"
configfound = 0

findpath
confirmpath(handlingpath)

deletefile cmpath
deletefile TBOGTcmpath
deletefile TLADcmpath
replacefile backuppath, handlingpath
replacefile TBOGTbackuppath, TBOGThandlingpath
replacefile TLADbackuppath, TLADhandlingpath

fixhandling

deletefolder cmfolder
deletefolder backupfolder
deletefolder TBOGTcmfolder
deletefolder TBOGTbackupfolder
deletefolder TLADcmfolder
deletefolder TLADbackupfolder
'---

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
		datapath = inputpath & "\common\data\"
		handlingpath = datapath & "handling.dat"
		backuppath = datapath & "backup\handling.dat"
		cmpath = datapath & "cm\handling.dat"
		TBOGTdatapath = inputpath & "\TBoGT\common\data\"
		TBOGThandlingpath = TBOGTdatapath & "handling.dat"
		TBOGTbackuppath = TBOGTdatapath & "backup\handling.dat"
		TBOGTcmpath = TBOGTdatapath & "cm\handling.dat"
		TLADdatapath = inputpath & "\TLAD\common\data\"
		TLADhandlingpath = TLADdatapath & "handling.dat"
		TLADbackuppath = TLADdatapath & "backup\handling.dat"
		TLADcmpath = TLADdatapath & "cm\handling.dat"
		
		cmfolder = datapath & "cm"
		backupfolder = datapath & "backup"
		TBOGTcmfolder = TBOGTdatapath & "cm"
		TBOGTbackupfolder = TBOGTdatapath & "backup"
		TLADcmfolder = TLADdatapath & "cm"
		TLADbackupfolder = TLADdatapath & "backup"
	Else
		inputpath = Inputbox( "Write the full path to your GTA IV Episodes from Liberty City directory. It can be 'C:\Program Files (x86)\Steam\steamapps\common\grand theft auto iv episodes from liberty city\EFLC', '(C:\Program Files\Grand Theft Auto IV Episodes From Liberty City' or wherever you have placed it. ",10,"C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV" )
		datapath = inputpath & "\common\data\"
		handlingpath = datapath & "handling.dat"
		backuppath = datapath & "backup\handling.dat"
		cmpath = datapath & "cm\handling.dat"
		TBOGTdatapath = inputpath & "\TBoGT\common\data\"
		TBOGThandlingpath = TBOGTdatapath & "handling.dat"
		TBOGTbackuppath = TBOGTdatapath & "backup\handling.dat"
		TBOGTcmpath = TBOGTdatapath & "cm\handling.dat"
		TLADdatapath = inputpath & "\TLAD\common\data\"
		TLADhandlingpath = TLADdatapath & "handling.dat"
		TLADbackuppath = TLADdatapath & "backup\handling.dat"
		TLADcmpath = TLADdatapath & "cm\handling.dat"
		
		cmfolder = datapath & "cm"
		backupfolder = datapath & "backup"
		TBOGTcmfolder = TBOGTdatapath & "cm"
		TBOGTbackupfolder = TBOGTdatapath & "backup"
		TLADcmfolder = TLADdatapath & "cm"
		TLADbackupfolder = TLADdatapath & "backup"
		
		Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
		objConfig.WriteLine(inputpath)
		objConfig.Close
	End if
End sub

Sub confirmpath(par3)
	configfound = 0
	Do until configfound = 1
		If objFSO.FileExists(par3) Then
			configfound = 1
			Exit do
		Else
				sContinue = MsgBox("Could not find handling.dat from the path you specified. Are you sure you wrote it correctly? Code: 11" & _ 
				vbCrLf & "Would you like to try writing it again?", 260, "Could not find file") 
			If sContinue <> 7 Then
				writepath
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

Sub deletefile(par8)
	If objFSO.FileExists(par8) Then
		objFSO.DeleteFile par8, True
		FilesFound = 1
	End if
End sub

Sub replacefile(par9, par10)
	If objFSO.FileExists(par9) Then
		objFSO.DeleteFile par10, True
		objFSO.MoveFile par9, par10
		FilesFound = 1
	End if
End sub

Sub deletefolder(par11)
	If objFSO.FolderExists(par11) Then
		set delefolder = objFSO.GetFolder(par11)
		delefolder.Delete
	End if
End sub

Sub fixhandling()
	if FilesFound = 0 Then
		If objFSO.FileExists(handlingpath) Then
			objFSO.DeleteFile handlingpath, True
			objFSO.CopyFile ".\GTAIV\handling.dat", handlingpath
		Else
			objFSO.CopyFile ".\GTAIV\handling.dat", handlingpath
		End if
	End if
End sub

Sub writepath()
	inputpath = Inputbox( "Write the full path to your GTA IV directory. It can be 'C:\Program Files\Steam\steamapps\common\grand theft auto iv\GTAIV', 'C:\Program Files\Rockstar Games\Grand Theft Auto IV' or wherever you have placed it." )
	datapath = inputpath & "\common\data\"
	handlingpath = datapath & "handling.dat"
	backuppath = datapath & "backup\handling.dat"
	cmpath = datapath & "cm\handling.dat"
	TBOGTdatapath = inputpath & "\TBoGT\common\data\"
	TBOGThandlingpath = TBOGTdatapath & "handling.dat"
	TBOGTbackuppath = TBOGTdatapath & "backup\handling.dat"
	TBOGTcmpath = TBOGTdatapath & "cm\handling.dat"
	TLADdatapath = inputpath & "\TLAD\common\data\"
	TLADhandlingpath = TLADdatapath & "handling.dat"
	TLADbackuppath = TLADdatapath & "backup\handling.dat"
	TLADcmpath = TLADdatapath & "cm\handling.dat"
	
	cmfolder = datapath & "cm"
	backupfolder = datapath & "backup"
	TBOGTcmfolder = TBOGTdatapath & "cm"
	TBOGTbackupfolder = TBOGTdatapath & "backup"
	TLADcmfolder = TLADdatapath & "cm"
	TLADbackupfolder = TLADdatapath & "backup"
	
	Set objConfig = objFSO.OpenTextFile(config, ForWriting, True)
	objConfig.WriteLine(inputpath)
	objConfig.Close
End sub