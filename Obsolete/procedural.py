import sys, re, os
from PyQt4 import QtCore, QtGui
from cm import Ui_CmMain
from winreg import ConnectRegistry, OpenKey, CloseKey, EnumValue, HKEY_LOCAL_MACHINE

class MainWindow(QtGui.QMainWindow):
	def __init__(self, parent=None):
		QtGui.QWidget.__init__(self, parent)
		self.ui = Ui_CmMain()
		self.ui.setupUi(self)
		#QtCore.QObject.connect(self.ui.findGTAEFLC,QtCore.SIGNAL("clicked()"), self.file_dialog)
		
		global cfgPath, GTAIVreg, EFLCreg, GTAIVpath, EFLCpath, noReg, saveHandling, GTAIVfound, EFLCfound
		EFLCpath = ""; GTAIVpath = ""; GTAIVfound = False; EFLCfound = False;
		GTAIVreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12210\InstallLocation"]
		EFLCreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12220\InstallLocation"]
		cfgPath = "config.cfg"
		savedHandling = "savedHandling.dat"
		getPath(GTAIVreg,"GTAIV")
		getPath(EFLCreg,"EFLC")	
		
def getPath(regPaths, prefix, cfgPath=""):
	global pathFound
	if os.path.isfile(cfgPath) != True:
		try:
			for regKey in regPaths:
				regRead(regKey, prefix)
				if pathFound == True:
					noReg = False
					break
		except EnvironmentError:
			noReg = True
			if prefix == "GTAIV":
				GTAIVpath = inputPath("GTAIV")
			if prefix == "EFLC":
				EFLCpath = inputPath("EFLC")
		else:
			setPaths()
	else:
		f = open(cfgPath, "r")
		for line in f:
			if re.search(".*GTAIV.*",line):
				if os.path.isfile(line):
					GTAIVpath = line
					GTAIVfound = True
			elif re.search(".*EFLC.*",line):
				if os.path.isfile(line):
					EFLCpath = line
					EFLCfound = True
		f.close()

def regRead(regPath,prefix):
	aReg = ConnectRegistry(None,HKEY_LOCAL_MACHINE)
	aKey = OpenKey(aReg, regPath)
	n = { }
	global noReg
	for i in range(1024):
		n['key'],n['value'],n['type'] = EnumValue(aKey,i)
		if (n['key'] == ('InstallLocation' or 'InstallFolder') and prefix == "GTAIV"):
			GTAIVpath = n['value']
			pathFound = True
			break
		elif (n['key'] == ('InstallLocation' or 'InstallFolder') and prefix == "EFLC"):
			EFLCpath = n['value']
			pathFound = True
			break
		else:
			pathFound = False
	CloseKey(aKey)
	CloseKey(aReg)
	
def setPaths():
	if GTAIVpath != "":
		GTAIVhandling = GTAIVpath + r"\common\data\handling.dat"; GTAIVback = GTAIVpath + r"\common\data\handling_backup.dat"; GTAIVcm = GTAIVpath + r"\common\data\handling_cm.dat";
	if EFLCpath != "":
		EFLChandling = EFLCpath + r"\common\data\handling.dat"; EFLCback = EFLCpath + r"\common\data\handling_backup.dat"; EFLCcm = EFLCpath + r"\common\data\handling_cm.dat";
		TLADhandling = EFLCpath + r"\TLAD\common\data\handling.dat"; TLADback = EFLCpath + r"\TLAD\common\data\handling_backup.dat"; TLADcm = EFLCpath + r"\TLAD\common\data\handling_cm.dat";
		TBoGThandling = EFLCpath + r"\TBoGT\common\data\handling.dat"; TBoGTback = EFLCpath + r"\TBoGT\common\data\handling_backup.dat"; TBoGTcm = EFLCpath + r"\TBoGT\common\data\handling_cm.dat";

def inputPath(prefix):
	global quitting; quitting = False;
	mockPath = input("Could not find " + prefix + " in the registry of your computer. Please input the full path to " + prefix + "'s main directory.")
	while quitting != True:
		if mockPath != "":
			if mockPath[-1] == "\\":
				mockPath = mockPath[:-1]
			if os.path.isdir(mockPath):
				if prefix == "GTAIV":
					GTAIVpath = mockPath
				elif prefix == "EFLC":
					EFLCpath = mockPath
				quitting = True
			else:
				mockPath = input("Could not find " + prefix + " at the specified path on your computer. Please input the full path to " + prefix + "'s main directory, or type \"quit\" to stop searching.")
		else:
			quitting = True
			print("No input")
					
if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	myapp = MainWindow()
	myapp.show()
	sys.exit(app.exec_())