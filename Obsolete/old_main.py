import sys, re, os
from PyQt4 import QtCore, QtGui
from cm import Ui_CmMain
from winreg import ConnectRegistry, OpenKey, CloseKey, EnumValue, HKEY_LOCAL_MACHINE

GTAIVreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12210\InstallLocation"]
EFLCreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12220\InstallLocation"]

class MainWindow(QtGui.QMainWindow):
	def __init__(self, parent=None):
		QtGui.QWidget.__init__(self, parent)
		self.ui = Ui_CmMain()
		self.ui.setupUi(self)
		global GTAIVcls, EFLCcls
		GTAIVcls = Game('Grand Theft Auto IV', 'GTAIV', GTAIVreg)
		EFLCcls = Game('Episodes From Liberty City', 'EFLC', EFLCreg)
		QtCore.QObject.connect(self.ui.findGTAIV,QtCore.SIGNAL("clicked()"), self.gtaIVpath)
		QtCore.QObject.connect(self.ui.findEFLC,QtCore.SIGNAL("clicked()"), self.EFLCpath)
	
	def gtaIVpath(cls):
		GTAIVcls.getPath
	def EFLCpath(cls):
		EFLCcls.getPath
		
	def inputBox(self, _name):
		text, ok = QtGui.QInputDialog.getText(self,"Carmageddon", 'Could not find the directory of ' + _name + ', please manually input the path in the text field below.<br />Clicking "Cancel" will disable this part of Carmageddon Mod.')
		if ok:
			return text
		elif ok == False:
			return ok
	
	def messageBox(self, _name, _initials):
		QtGui.QMessageBox.about(self, 'Component disabled', 'The ' + _name + '-component of Carmageddon mod is now disabled. To enable it again, click the "Find ' + _initials + '" button.')
		
class Game(QtGui.QFileDialog):
	def __init__(self, name, initials, paths, exp = "", parent = None):
		QtGui.QFileDialog.__init__(self, parent)
		self.paths = [ ]
		self.paths = paths
		self.name = name
		self.initials = initials
		self.cfgPath = initials + "config.cfg"
		self.pathFound = False
		self.gamePath = ""; self.handPath = ""; self.backPath = ""; self.cmPath = "";
		self.exp = 'self.status_' + initials + '.setText(self.newStatus)'
		self.getPath()
		global CHECKING, ENABLED, DISABLED, ACTIVATED, DEACTIVATED, NOTFOUND, FOUND
		CHECKING = "Checking status..."; ENABLED = "Enabled"; DISABLED = "Disabled"; ACTIVATED = "Activated"; DEACTIVATED = "Deactivated"; NOTFOUND = "Not found"; FOUND = "Found"
		
	def getPath(self):
		if os.path.isfile(self.cfgPath) != True:
			self.regRead()
		else:
			self.readConfig()
		if self.pathFound == False:
			self.regRead()
			if self.pathFound == False:
				self.inputPath()
		self.setPaths()
			
	def regRead(self):
		for regKey in self.paths:
			try:
				aReg = ConnectRegistry(None,HKEY_LOCAL_MACHINE)
				aKey = OpenKey(aReg, regKey)
				n = { }
				for i in range(1024):
					n['key'],n['value'],n['type'] = EnumValue(aKey,i)
					if n['key'] == ('InstallLocation' or 'InstallFolder'):
						if os.path.isdir(n['value']):
							self.gamePath = n['value']
							self.pathFound = True
							break
						else: 
							self.pathFound = False
					else:
						self.pathFound = False
				CloseKey(aKey)
				CloseKey(aReg)
				if self.pathFound == True:
					break
			except EnvironmentError:
				pass
				
	def readConfig(self):
		f = open(self.cfgPath, "r")
		for line in f:
			if os.path.isdir(line):
				self.gamePath = line
				self.pathFound = True
		f.close()
		
	def setPaths(self):
		if self.pathFound == "":
			self.handPath = self.gamePath + r"\common\data\handling.dat"; self.backPath = self.gamePath + r"\common\data\handling_backup.dat"; self.cmPath = self.gamePath + r"\common\data\handling_cm.dat";
			self.newStatus = FOUND
			self.statusUpdate()
			return True
		else:
			return False
			
	def inputPath(self):
		_halt = False
		while _halt != True:
			result = MainWindow.inputBox(self, self.name)
			if result != False:
				try:
					while result[-1] == "\\":
						result = result[:-1]
					if os.path.isdir(result):
						self.gamePath = result
						_halt = True
				except IndexError:
					pass
			else:
				MainWindow.messageBox(self, self.name, self.initials)
				_halt = True
			
	def statusUpdate(self,text):
		eval(self.exp)


if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	myapp = MainWindow()
	myapp.show()
	sys.exit(app.exec_())
	