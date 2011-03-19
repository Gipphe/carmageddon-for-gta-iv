Dim strComputer, objWMIService, colSettings, objProcessor

strComputer = "."

Set objWMIService = GetObject("winmgmts:" _ 
  & "{impersonationLevel=impersonate,authenticationLevel=Pkt}!\\" _ 
  & strComputer & "\root\cimv2") 

Set colSettings = objWMIService.ExecQuery _
  ("SELECT * FROM Win32_Processor")

For Each objProcessor In colSettings
		if objProcessor.AddressWidth = 64 Then
'---------------------

'Deactivation
Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
If objFSO.FileExists("c:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") Then 
    Set objFolder = objFSO.GetFile("c:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") 
    Wscript.Echo "Carmageddon needed to be deactivated before it could be uninstalled, but it is already deactivated. Continuing uninstallation."
        wScript.Quit()

Else 
    Wscript.Echo "Carmageddon needes to be deactivated before it can be uninstalled. Deactivating now." 
End If 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~2\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") 
    Wscript.Echo errResult 
Next 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~2\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_backup.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~2\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling.dat") 
    Wscript.Echo errResult 
Next 

Wscript.Echo "Carmageddon deactivated successfully. Continuing uninstallation."
    		WScript.Quit() 

'---------------------
		ElseIf objProcessor.Addresswidth = 32 Then
'---------------------

'Deactivation
Set objFSO = CreateObject("Scripting.FileSystemObject") 
 
If objFSO.FileExists("c:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") Then 
    Set objFolder = objFSO.GetFile("c:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") 
    Wscript.Echo "Carmageddon needed to be deactivated before it could be uninstalled, but it is already deactivated. Continuing uninstallation."
        wScript.Quit()

Else 
    Wscript.Echo "Carmageddon needes to be deactivated before it can be uninstalled. Deactivating now." 
End If 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~1\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling_carmageddon.dat") 
    Wscript.Echo errResult 
Next 

strComputer = "." 
Set objWMIService = GetObject("winmgmts:" _ 
    & "{impersonationLevel=impersonate}\\" & strComputer & "\root\cimv2") 
 
Set colFiles = objWMIService.ExecQuery _ 
    ("Select * from Cim_Datafile where Name = " _ 
        & "'c:\\Progra~1\\Steam\\steamapps\\common\\grand theft auto iv\\GTAIV\\common\\data\\handling_backup.dat'") 
 
For Each objFile in colFiles 
    errResult = objFile.Rename("c:\Progra~1\Steam\steamapps\common\grand theft auto iv\GTAIV\common\data\handling.dat") 
    Wscript.Echo errResult 
Next 

Wscript.Echo "Carmageddon deactivated successfully. Continuing uninstallation."
    		WScript.Quit() 


'---------------------
		End If
Next
