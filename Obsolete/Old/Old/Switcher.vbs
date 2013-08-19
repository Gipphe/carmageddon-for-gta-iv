		Option Explicit
		Dim objFSO, config, sContinue, configfound, FolderCreate, cmfolder, backupfolder, handlingfolder, datapath, cmpath, handlingpath, backuppath, objConfig, objFile, i, strLine, TBOGThandlingpath, TLADhandlingpath, TLADdatapath, TLADcmpath, TLADbackuppath, TLADbackupfolder, TLADcmfolder, TBOGTdatapath, TBOGTbackuppath, TBOGTcmpath, TBOGTbackupfolder, TBOGTcmfolder, inputpath, par1, par3, par4, par5, par6, par7, par8, NotReadRights, strComputer, strKeyPath1, strKeyPath2, strKeyPath3, strValueName1, strValueName3, oReg, strValue, KEY_QUERY_VALUE, bHasAccessRight, quitting, EFLChandlingpath, EFLCcmpath, EFLCbackuppath, EFLCcmfolder, EFLCbackupfolder, EFLCconfig, eflcstrKeyPath1, eflcstrKeyPath2, eflcstrKeyPath3, EFLCinputpath, eflcdatapath, iseflc
		
		Dim arrFileLines()

		Set objFSO = CreateObject("Scripting.FileSystemObject")

		Const ForReading = 1, ForWriting = 2, ForAppending = 8
		Const HKEY_QUERY_VALUE = &H0001	 
		Const HKEY_LOCAL_MACHINE = &H80000002
		config = ".\GTAIVpath.ini"
		EFLCconfig = ".\EFLCpath.ini"
		strComputer = "."
		Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
		
		strKeyPath1 = "SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV"
		strKeyPath2 = "SOFTWARE\Rockstar Games\Grand Theft Auto IV"
		strKeyPath3 = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12210"
		strValueName1 = "InstallFolder"
		strValueName3 = "InstallLocation"
		
		eflcstrKeyPath1 = "SOFTWARE\Wow6432Node\Rockstar Games\EFLC"
		eflcstrKeyPath2 = "SOFTWARE\Rockstar Games\EFLC"
		eflcstrKeyPath3 = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12220"


		'---
		'Main

		
		if checkregistryaccess then
			readpath
			readpath
		
		Sub gtaivcarrier()
			quitting = false
			confirmpath handlingpath
			if quitting = false then
				installfiles(false)
				if quitting = false then
					scriptrun(false)
				elseif quitting = true then
					msgbox "Ending script. Code: 14"
				end if
			elseif quitting = true then
				msgbox "Ending script. Code: 15"
			end if
			getgtaivstatus
		End sub
		
		Sub eflccarrier()
			quitting = false
			confirmpath EFLChandlingpath
			confirmpath TBoGThandlingpath
			confirmpath TLADhandlingpath
			if quitting = false then
				installfiles(true)
				if quitting = false then
					scriptrun(true)
				elseif quitting = true then
					msgbox "Ending script. Code: 16"
				end if
			elseif quitting = true then
				msgbox "Ending script. Code: 17"
			end if
			geteflcstatus
		End sub


		'---
		'Subroutines

		Sub readpath
			' EFLC reg check run
			If NotReadRights = 1 then
				findpath(true)
			elseif NotReadRights = 0 then
				if iseflc = true then
					findregentry eflcstrKeyPath1,strValueName1,true
					if inputpath = "" then
						findregentry eflcstrKeyPath2,strValueName1,true
						if inputpath = "" then
							findregentry eflcstrKeyPath3,strValueName3,true
							if EFLCinputpath = "" then
								findpath(true)
							end if
							EFLCinputpath = EFLCinputpath & "\EFLC"
						end if
					end if
				end if
			else
				msgbox "Some really gunky shit happened (an impossible value became possible) and I dunno what the fuck to do! >.< Error code: 42" & _
				vbCrLf & "Nonetheless, I'll try to continue on; I'll notify you if something else's weird."
				findpath(true)	
			end if
			' GTAIV reg check run
			If NotReadRights = 1 then
				findpath(false)			
			elseif NotReadRights = 0 then
				findregentry strKeyPath1,strValueName1,false
				if inputpath = "" then
					findregentry strKeyPath2,strValueName1,false
					if inputpath = "" then
						findregentry strKeyPath3,strValueName3,false
						if inputpath = "" then
							findpath(false)
						End if
						inputpath = inputpath & "\GTAIV"
					End if
				End if
			else
				msgbox "Some really gunky shit happened (an impossible value became possible) and I dunno what the fuck to do! >.< Error code: 42" & _
				vbCrLf & "Nonetheless, I'll try to continue on; I'll notify you if something else's weird."
				findpath(false)	
			End if
		End sub

		Sub findpath
			'EFLC Path retrieval
			If objFSO.FileExists(EFLCconfig) Then
				Set objFileEFLC = objFSO.OpenTextFile(EFLCconfig, ForReading)

				i = 0
				Do Until objFile.AtEndOfStream
				Redim Preserve arrFileLines(i)
				arrFileLines(i) = objFileEFLC.ReadLine
				i = i + 1
				Loop
				objFile.Close

				For Each strLine in arrFileLines
				EFLCinputpath = strLine
				Next
				EFLCsetpaths
			Else
				EFLCinputpath = Inputbox( "Write the full path to your EFLC directory. It can be 'C:\Program Files (x86)\Steam\steamapps\common\grand theft auto iv episodes from liberty city\EFLC', '(C:\Program Files\Rockstar Games\EFLC' or wherever you have placed it. ",10,"C:\Program Files\Steam\steamapps\common\grand theft auto iv episodes from liberty city\EFLC" )
				EFLCsetpaths
				
				Set objConfig = objFSO.OpenTextFile(EFLCconfig, ForWriting, True)
				objConfig.WriteLine(EFLCinputpath)
				objConfig.Close
			End if
			'GTAIV path retrieval
			If objFSO.FileExists(config) Then
				Set objFile = objFSO.OpenTextFile(config, ForReading)

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

		Sub setpaths
			datapath = inputpath & "\common\data\"
			handlingpath = datapath & "handling.dat"
			backuppath = datapath & "backup\handling_backup.dat"
			cmpath = datapath & "cm\handling_carmageddon.dat"

			cmfolder = datapath & "cm"
			backupfolder = datapath & "backup"
		End sub
		
		Sub EFLCsetpaths()
			EFLCdatapath = EFLCinputpath & "\common\data\"
			EFLChandlingpath = EFLCdatapath & "handling.dat"
			EFLCcmpath = EFLCdatapath & "cm\handling_carmageddon.dat"
			EFLCbackuppath = EFLCdatapath & "backup\handling_backup.dat"
			
			TBOGTdatapath = EFLCinputpath & "\TBoGT\common\data\"
			TBOGThandlingpath = TBOGTdatapath & "handling.dat"
			TBOGTbackuppath = TBOGTdatapath & "backup\handling.dat"
			TBOGTcmpath = TBOGTdatapath & "cm\handling.dat"
			
			TLADdatapath = EFLCinputpath & "\TLAD\common\data\"
			TLADhandlingpath = TLADdatapath & "handling.dat"
			TLADbackuppath = TLADdatapath & "backup\handling.dat"
			TLADcmpath = TLADdatapath & "cm\handling.dat"
			
			EFLCcmfolder = EFLCdatapath & "cm"
			EFLCbackupfolder = EFLCdatapath & "backup"
			
			TBOGTcmfolder = TBOGTdatapath & "cm"
			TBOGTbackupfolder = TBOGTdatapath & "backup"
			
			TLADcmfolder = TLADdatapath & "cm"
			TLADbackupfolder = TLADdatapath & "backup"
		End sub

		Sub confirmpath(par3)
			configfound = 0
			Do until configfound = 1 or quitting = true
				If objFSO.FileExists(par3) Then
					configfound = 1
					Exit do
				Else
					msgbox "This is the path we're checking: " & vbcrlf & par3
					sContinue = MsgBox("Could not find handling.dat from the path specified. Are you sure you wrote it correctly? Code: 11" & vbCrLf & "Would you like to try writing it?", 260, "Could not find critical file") 
					If sContinue <> 7 Then
						findpath
					Elseif		sContinue <> 6 Then
						sContinue = MsgBox("Carmageddon mod will not work properly otherwise. Are you sure? This will exit the script.", 260, "Are you sure you want to exit?") 
						If sContinue <> 7 Then
							quitting = true
						Elseif sContinue <> 6 Then	
							Call findpath
						End if
					End if
				End if
			Loop
		End sub

		Sub scriptrun(iseflc)
			if iseflc = false then
				If objFSO.FileExists(backuppath) Then
					If objFSO.FileExists(cmpath) Then
						msgbox "Something's wrong: there exists a backup of the original, the carmageddon version AND an active file (it is unknown which version version of the file this is), all at the same time." & _
						vbCrLf & "Delete either the backup or the carmageddon backup. They can be found in folders in your '\common\data' folder." & _
						vbCrLf & "Check the active file to see which of them it is, and delete the other one."
					elseif not objFSO.FileExists(cmpath) Then
						'sContinue = MsgBox("Carmageddon is currently active." & _ 
						'vbCrLf & "Would you like to deactivate Carmageddon?", 260, "Carmageddon active") 
						'If sContinue <> 7 Then
							objFSO.MoveFile handlingpath, cmpath
							objFSO.MoveFile backuppath, handlingpath
						'	msgbox "Carmageddon deactivated."
							quitting = true
						'Elseif		sContinue <> 6 Then
						'	msgbox "Carmageddon will remain active. Exiting."
						'	quitting = true 
						'End If 
					End if
				Elseif not objFSO.FileExists(backuppath) Then
					If objFSO.FileExists(cmpath) Then
						' sContinue = MsgBox("Carmageddon is currently inactive." & _ 
						' vbCrLf & "Would you like to activate Carmageddon?", 260, "Carmageddon inactive") 
						' If sContinue <> 7 Then
							objFSO.MoveFile handlingpath, backuppath 
							objFSO.MoveFile cmpath, handlingpath 
						'	msgbox "Carmageddon activated."
							quitting = true
						'Elseif		sContinue <> 6 Then
						'	msgbox "Carmageddon will remain inactive. Exiting."
						'	quitting = true
						'End if
					Elseif not objFSO.FileExists(cmpath) Then
						msgbox "Couldn't find neither the original backup nor carmageddon's backup. Something went wrong during the implementation." & _
						vbCrLf & "Try running Implementer.vbs in Carmageddon's installation directory or contact Gipphe for support."
						quitting = true
					End if
				End if
			elseif iseflc = true then
				If objFSO.FileExists(EFLCbackuppath) Then
					If objFSO.FileExists(EFLCcmpath) Then
						msgbox "Something's wrong: there exists a backup of the original, the carmageddon version AND an active file (it is unknown which version version of the file this is), all at the same time." & _
						vbCrLf & "Delete either the backup or the carmageddon backup. They can be found in folders in your '\common\data' folder." & _
						vbCrLf & "Check the active file to see which of them it is, and delete the other one."
					elseif not objFSO.FileExists(EFLCcmpath) Then
						'sContinue = MsgBox("Carmageddon is currently active." & _ 
						'vbCrLf & "Would you like to deactivate Carmageddon?", 260, "Carmageddon active") 
						'If sContinue <> 7 Then
						objFSO.MoveFile EFLChandlingpath, EFLCcmpath
						objFSO.MoveFile EFLCbackuppath, EFLChandlingpath
						objFSO.MoveFile TBOGThandlingpath, TBOGTcmpath
						objFSO.MoveFile TBOGTbackuppath, TBOGThandlingpath
						objFSO.MoveFile TLADhandlingpath, TLADcmpath
						objFSO.MoveFile TLADbackuppath, TLADhandlingpath
						'	msgbox "Carmageddon deactivated."
							quitting = true
						'Elseif		sContinue <> 6 Then
						'	msgbox "Carmageddon will remain active. Exiting."
						'	quitting = true 
						'End If 
					End if
				Elseif not objFSO.FileExists(EFLCbackuppath) Then
					If objFSO.FileExists(EFLCcmpath) Then
						' sContinue = MsgBox("Carmageddon is currently inactive." & _ 
						' vbCrLf & "Would you like to activate Carmageddon?", 260, "Carmageddon inactive") 
						' If sContinue <> 7 Then
						objFSO.MoveFile EFLChandlingpath, EFLCbackuppath 
						objFSO.MoveFile EFLCcmpath, EFLChandlingpath 
						objFSO.MoveFile TBOGThandlingpath, TBOGTbackuppath
						objFSO.MoveFile TBOGTcmpath, TBOGThandlingpath
						objFSO.MoveFile TLADhandlingpath, TLADbackuppath
						objFSO.MoveFile TLADcmpath, TLADhandlingpath
						'	msgbox "Carmageddon activated."
							quitting = true
						'Elseif		sContinue <> 6 Then
						'	msgbox "Carmageddon will remain inactive. Exiting."
						'	quitting = true
						'End if
					Elseif not objFSO.FileExists(cmpath) Then
						msgbox "Couldn't find neither the original backup nor carmageddon's backup. Something went wrong during the implementation." & _
						vbCrLf & "Try running Implementer.vbs in Carmageddon's installation directory or contact Gipphe for support."
						quitting = true
					End if
				End if
			End if
		End sub

		Sub makefolder(folderpath)
			If not objFSO.FolderExists(folderpath) Then
				objFSO.CreateFolder(folderpath)
				If not objFSO.FolderExists(folderpath) Then
					msgbox "Could not create folder:" & folderpath & vbcrlf & "Carmageddon mod will NOT work. Error code: 994-" & folderpath
				End if
			End if
		End sub

		Sub implementfile(folderpath, filename, filepath, iseflc)
			if iseflc = true then
				If objFSO.FolderExists(folderpath) Then
					If not objFSO.FileExists(filepath) then
						If filepath = ".\GTAIV\handling_carmageddon.dat" then
							if not objFSO.FileExists(EFLCbackuppath) then
								objFSO.CopyFile filename, filepath
							End if
						elseif filepath = ".\TBOGT\handling_carmageddon.dat" then
							if not objFSO.FileExists(TBOGTbackuppath) then
								objFSO.CopyFile filename, filepath
							end if
						elseif filepath = ".\TLAD\handling_carmageddon.dat" then
							if not objFSO.FileExists(TLADbackuppath) then
								objFSO.CopyFile filename, filepath
							End if
						End if
					end if
				ElseIf Not objFSO.FolderExists(folderpath) Then
					msgbox "Encountered an error while trying to implement carmageddon's files: " & folderpath & " does not exist. Carmageddon will NOT work. Error code: 9997"
					quitting = true
				End If
			elseif iseflc = false then
				If objFSO.FolderExists(folderpath) Then
					If not objFSO.FileExists(filepath) then
						if not objFSO.FileExists(backuppath) then
							objFSO.CopyFile filename, filepath
						End if
					end if
				ElseIf Not objFSO.FolderExists(folderpath) Then
					msgbox "Encountered an error while trying to implement carmageddon's files: " & folderpath & " does not exist. Carmageddon will NOT work. Error code: 9997"
					quitting = true
				End If
			End if
		End sub

		Sub installfiles(iseflc)
			if iseflc = true then
				makefolder(EFLCcmfolder)
				makefolder(EFLCbackupfolder)
				makefolder(TBOGTcmfolder)
				makefolder(TBOGTbackupfolder)
				makefolder(TLADcmfolder)
				makefolder(TLADbackupfolder)
			elseif iseflc = false then
				makefolder(cmfolder)
				makefolder(backupfolder)
			end if

			if iseflc = false then
				if configfound = 1 Then
					implementfile cmfolder, ".\GTAIV\handling_carmageddon.dat", cmpath, false
				elseif not configfound = 1 Then
					msgbox "A critical error occurred. Error code: 10000"
					quitting = true
				End if
			elseif iseflc = true then
				if configfound = 1 Then
					implementfile EFLCcmfolder, ".\GTAIV\handling_carmageddon.dat", EFLCcmpath, true
					implementfile TBOGTcmfolder, ".\TBOGT\handling_carmageddon.dat", TBOGTcmpath, true
					implementfile TLADcmfolder, ".\TLAD\handling_carmageddon.dat", TLADcmpath, true
				elseif not configfound = 1 Then
					msgbox "A critical error occurred. Error code 10001"
					quitting = true
				End if
			End if
		End sub

		Function checkregistryaccess
			Dim strKeyPath
			strKeyPath = "SYSTEM\CurrentControlSet"
				 
			oReg.CheckAccess HKEY_LOCAL_MACHINE, strKeyPath, KEY_QUERY_VALUE, _
				bHasAccessRight
			If bHasAccessRight = False Then
				statusarea.innerhtml = "You do not have registry read rights."
				return false
			Elseif bHasAccessRight = true then
				return true
			End If   
		End function

		Sub findregentry(entrylocation,entryvalue,iseflc)
			oReg.GetStringValue HKEY_LOCAL_MACHINE,entrylocation,entryvalue,strValue
			inputpath = strValue
			if iseflc = true then
				EFLCinputpath = inputpath
				EFLCsetpaths
			elseif iseflc = false then
				setpaths
			end if
		End sub