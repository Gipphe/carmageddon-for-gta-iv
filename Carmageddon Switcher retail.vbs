
' ----- ExeScript Options Begin -----
' ScriptType: window,activescript,invoker
' DestDirectory: temp
' Icon: C:\Users\Victor\Desktop\Carmageddon\Giphtworks.ico
' OutputFile: C:\Users\Victor\Desktop\Carmageddon\Carmageddon Switcher.exe
' Comments: Activate/Deactivate Carmageddon
' CompanyName: Giphtworks
' FileDescription: Activate/Deactivate Carmageddon
' FileVersion: 1.5.0.1
' LegalCopyright: Giphtworks
' ProductName: Carmageddon
' ProductVersion: 1.0.0.0
' ----- ExeScript Options End -----

Dim strComputer, objWMIService, colSettings, objProcessor

strComputer = "."

Set objWMIService = GetObject("winmgmts:" _ 
  & "{impersonationLevel=impersonate,authenticationLevel=Pkt}!\\" _ 
  & strComputer & "\root\cimv2") 

Set colSettings = objWMIService.ExecQuery _
  ("SELECT * FROM Win32_Processor")

For Each objProcessor In colSettings
		if objProcessor.AddressWidth = 64 Then
'-------------------------------------

	sContinue = MsgBox("Welcome to Carmageddon Switcher. Click 'yes' to activate Carmageddon. Click 'no' to deactivate Carmageddon." & _ 
    		vbCrLf & "None of the options will ruin anything, regardless if it's already active or not.", 260, "Carmageddon switcher") 
	If sContinue <> 7 Then
'-----------------------------------------------------------------
'Activation
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
	If objFSO.FileExists("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") Then 
    		Set objFolder = objFSO.GetFile("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") 
    		Wscript.Echo "You have already activated carmageddon. Exiting."
        	wScript.Quit()

	Else 
    		Wscript.Echo "Activating carmageddon. Just click ok in the next two boxes. If they show anything other than 0, please yell at me." 
	End If 


	strComputer = "." 
	Set objWMIService = GetObject("winmgmts:" _ 
    		& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
	Set colFiles = objWMIService.ExecQuery _ 
    		("Select * from Cim_Datafile where Name = " _ 
        	& "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'") 
 
	For Each objFile in colFiles 
    		errResult = objFile.Rename("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") 
    		Wscript.Echo errResult 
	Next 

	strComputer = "." 
	Set objWMIService = GetObject("winmgmts:" _ 
    		& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
	Set colFiles = objWMIService.ExecQuery _ 
    		("Select * from Cim_Datafile where Name = " _ 
        	& "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_carmageddon.dat'") 
 
	For Each objFile in colFiles 
    		errResult = objFile.Rename("c:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling.dat") 
    		Wscript.Echo errResult 
	Next 

	Wscript.Echo "Carmageddon Activated. If it said anything else than 0 in those two boxes, it fucked up, and you have to manually fix it yourself. Good luck :D"


	wScript.Quit()
'-----------------------------------------------------------------
Else if		sContinue <> 6 Then
'-----------------------------------------------------------------
'Deactivation
Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
If objFSO.FileExists("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") Then 
    Set objFolder = objFSO.GetFile("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") 
    Wscript.Echo "Carmageddon isn't activated. Exiting."
        wScript.Quit()

Else 
    Wscript.Echo "Deactivating carmageddon. Just click ok in the next two boxes. If they show anything other than 0, please yell at me." 
End If 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") 
    Wscript.Echo errResult 
Next 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~2\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_backup.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~2\Rockstar Games\Grand Theft Auto IV\common\data\handling.dat") 
    Wscript.Echo errResult 
Next 

Wscript.Echo "Carmageddon deactivated successfully. If it said anything else than 0 in those two boxes, it fucked up, and you have to manually fix it yourself. Good luck :D"
    		WScript.Quit() 
End If 
End If

'-------------------------------------
		ElseIf objProcessor.Addresswidth = 32 Then
'-------------------------------------

sContinue = MsgBox("Welcome to Carmageddon Switcher. Click 'yes' to activate Carmageddon. Click 'no' to deactivate Carmageddon." & _ 
    vbCrLf & "None of the options will ruin anything, regardless if it's already active or not.", 260, "Carmageddon switcher") 
If sContinue <> 7 Then
'-----------------------------------------------------------------
'Activation
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
	If objFSO.FileExists("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") Then 
    		Set objFolder = objFSO.GetFile("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") 
    		Wscript.Echo "You have already activated carmageddon. Exiting."
        	wScript.Quit()

	Else 
    		Wscript.Echo "Activating carmageddon. Just click ok in the next two boxes. If they show anything other than 0, please yell at me." 
	End If 


	strComputer = "." 
	Set objWMIService = GetObject("winmgmts:" _ 
    		& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
	Set colFiles = objWMIService.ExecQuery _ 
    		("Select * from Cim_Datafile where Name = " _ 
        	& "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'") 
 
	For Each objFile in colFiles 
    		errResult = objFile.Rename("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_backup.dat") 
    		Wscript.Echo errResult 
	Next 

	strComputer = "." 
	Set objWMIService = GetObject("winmgmts:" _ 
    		& "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
	Set colFiles = objWMIService.ExecQuery _ 
    		("Select * from Cim_Datafile where Name = " _ 
        	& "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_carmageddon.dat'") 
 
	For Each objFile in colFiles 
    		errResult = objFile.Rename("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling.dat") 
    		Wscript.Echo errResult 
	Next 

	Wscript.Echo "Carmageddon Activated. If it said anything else than 0 in those two boxes, it fucked up, and you have to manually fix it yourself. Good luck :D"


	wScript.Quit()
'-----------------------------------------------------------------
Else if		sContinue <> 6 Then
'-----------------------------------------------------------------
'Deactivation
Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
If objFSO.FileExists("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") Then 
    Set objFolder = objFSO.GetFile("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") 
    Wscript.Echo "Carmageddon isn't activated. Exiting."
        wScript.Quit()

Else 
    Wscript.Echo "Deactivating carmageddon. Just click ok in the next two boxes. If they show anything other than 0, please yell at me." 
End If 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling_carmageddon.dat") 
    Wscript.Echo errResult 
Next 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~1\\Rockstar Games\\Grand Theft Auto IV\\common\\data\\handling_backup.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~1\Rockstar Games\Grand Theft Auto IV\common\data\handling.dat") 
    Wscript.Echo errResult 
Next 

Wscript.Echo "Carmageddon deactivated successfully. If it said anything else than 0 in those two boxes, it fucked up, and you have to manually fix it yourself. Good luck :D"
    		WScript.Quit() 
End If 
End If

'-------------------------------------
		Else
			wScript.Echo "Carmageddon is not compatible with your system."
			wScript.Quit()
		End If
Next
