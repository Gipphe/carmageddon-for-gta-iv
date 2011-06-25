
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
Dim objFSO, config, sContinue, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, cmpath, handlingpath, backuppath, objConfig, objFile, i, strLine, TBOGThandlingpath, TLADhandlingpath, TLADdatapath, TLADcmpath, TLADbackuppath, TLADbackupfolder, TLADcmfolder, TBOGTdatapath, TBOGTbackuppath, TBOGTcmpath, TBOGTbackupfolder, TBOGTcmfolder, inputpath, par1, par3, par4, par5, par6, par7, par8

Const ForReading = 1, ForWriting = 2, ForAppending = 8
config = ".\EFLCpath.txt"

Set objFSO = CreateObject("Scripting.FileSystemObject")

findpath
confirmpath(handlingpath)

scriptrun



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

Sub makefolder(par1)
	If not objFSO.FolderExists(par1) Then
		objFSO.CreateFolder(par1)
		If not objFSO.FolderExists(par1) Then
			wscript.echo "Could not create folder:" & par1
		End if
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

Sub confirmpathEFLC(par7)
	configfound = 0
	If objFSO.FileExists(par3) Then
		configfound = 1
	Else if not objFSO.FileExists(par3) Then
		configfound = 0
	End if
	End if
End sub

Sub scriptrun
	If objFSO.FileExists(backuppath) Then
		If objFSO.FileExists(cmpath) Then
			wscript.echo "Something's wrong: there exists a backup, carmageddon backup AND active file, all at the same time. Delete either the backup or the carmageddon backup. They can be found in folders in your '\common\data' folder"
		else if not objFSO.FileExists(cmpath) Then
			sContinue = MsgBox("Carmageddon is currently active." & _ 
			vbCrLf & "Would you like to deactivate Carmageddon?", 260, "Carmageddon active") 
			If sContinue <> 7 Then
				objFSO.MoveFile handlingpath, cmpath
				objFSO.MoveFile backuppath, handlingpath
				objFSO.MoveFile TBOGThandlingpath, TBOGTcmpath
				objFSO.MoveFile TBOGTbackuppath, TBOGThandlingpath
				objFSO.MoveFile TLADhandlingpath, TLADcmpath
				objFSO.MoveFile TLADbackuppath, TLADhandlingpath
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
				objFSO.MoveFile TBOGThandlingpath, TBOGTbackuppath
				objFSO.MoveFile TBOGTcmpath, TBOGThandlingpath
				objFSO.MoveFile TLADhandlingpath, TLADbackuppath
				objFSO.MoveFile TLADcmpath, TLADhandlingpath
				wscript.echo "Carmageddon activated."
				wscript.quit()
			Else if		sContinue <> 6 Then
				WScript.Echo "Carmageddon will remain inactive. Exiting."
				WScript.Quit() 
			End If 
			End if
		Else if not objFSO.FileExists(cmpath) Then
			wscript.echo "Couldn't find neither the original backup nor carmageddon's backup. Something went wrong during the installation. Contact the creator."
			wscript.quit()
		End if
	End if
	End if
	End if
End sub