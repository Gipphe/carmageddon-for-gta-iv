'''
Switches between the active state and inactive state of Carmageddon mod for GTAIV and EFLC.
'''

import sys, os, shutil, filecmp, inspect
from time import gmtime, strftime
from PyQt4 import QtCore, QtGui
from cm import Ui_CmMain
from uuid import uuid1
from winreg import ConnectRegistry, OpenKey, CloseKey, EnumValue, HKEY_LOCAL_MACHINE

GTAIVreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Rockstar Games\Grand Theft Auto IV\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12210\InstallLocation"]
EFLCreg = [r"SOFTWARE\Wow6432Node\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Rockstar Games\EFLC\InstallFolder", r"SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12220\InstallLocation"]
Colors = { 'red' : '#FF9E9E', 'green' : '#9EFF9E' }

class MainWindow(QtGui.QMainWindow):
	def __init__(self, parent=None):
		'''
		Main window class.
		'''
		QtGui.QWidget.__init__(self, parent)
		global windowUI, lastFolder, GTAIVcls, EFLCcls, TLADcls, TBoGTcls
		lastFolder = "."
		windowUI = Ui_CmMain()
		windowUI.setupUi(self)
		self.setFixedSize(180,286)
		self.window
		self.buttonsEnabled = True
		self.Vals = { 'log' : r".\log.log" }
		GTAIVcls = Game('Grand Theft Auto IV', 'GTAIV', GTAIVreg, self.Vals['log'])
		EFLCcls = Game('Episodes From Liberty City', 'EFLC', EFLCreg, self.Vals['log'])
		self.connect(windowUI.findGTAIV,QtCore.SIGNAL("clicked()"), self.GTAIVfind)
		self.connect(windowUI.findEFLC,QtCore.SIGNAL("clicked()"), self.EFLCfind)
		self.connect(windowUI.toggle_GTAIV,QtCore.SIGNAL("clicked()"), self.GTAIVtoggle)
		self.connect(windowUI.toggle_EFLC,QtCore.SIGNAL("clicked()"), self.EFLCtoggle)
		self.connect(windowUI.fixGTAIV,QtCore.SIGNAL("clicked()"), self.GTAIVfix)
		self.connect(windowUI.fixEFLC,QtCore.SIGNAL("clicked()"), self.EFLCfix)
		GTAIVcls.getPath()
		GTAIVcls.checkState()
		EFLCcls.getPath()
		EFLCcls.checkState()

	def GTAIVfind(self):
		'''
		Take input to find GTAIV's location.
		'''
		self.toggleButtons()
		windowUI.statusLine.setText('<html><head></head><body><p align="center">Prompting for path to GTAIV...</p></body></html>')
		GTAIVcls.getPath(False,False,True)
		self.toggleButtons()

	def EFLCfind(self):
		'''
		Take input to find EFLC's location.
		'''
		self.toggleButtons()
		windowUI.statusLine.setText('<html><head></head><body><p align="center">Prompting for path to GTAIV...</p></body></html>')
		EFLCcls.getPath(False,False,True)
		self.toggleButtons()

	def GTAIVtoggle(self):
		'''
		Toggle GTAIV's state.
		'''
		self.toggleButtons()
		GTAIVcls.toggleState()
		if GTAIVcls.Game['state'] == "ACTIVE":
			windowUI.statusLine.setText('<html><head></head><body><p align="center" style="color: red; background: solid ' + Colors['red'] + ';">GTAIV active</p></body></html>')
		elif GTAIVcls.Game['state'] == "INACTIVE":
			windowUI.statusLine.setText('<html><head></head><body><p align="center" style="color: black; background: solid ' + Colors['green'] + ';">GTAIV inactive</p></body></html>')
		self.toggleButtons()

	def EFLCtoggle(self):
		'''
		Toggle EFLC's state.
		'''
		self.toggleButtons()
		EFLCcls.toggleState()
		if EFLCcls.Game['state'] == "ACTIVE":
			windowUI.statusLine.setText('<html><head></head><body><p align="center" style="color: red; background: solid ' + Colors['red'] + ';">EFLC active</p></body></html>')
		elif EFLCcls.Game['state'] == "INACTIVE":
			windowUI.statusLine.setText('<html><head></head><body><p align="center" style="color: black; background: solid ' + Colors['green'] + ';">EFLC inactive</p></body></html>')
		self.toggleButtons()

	def GTAIVfix(self):
		'''
		Fix GTAIV's files.
		'''
		self.toggleButtons()
		GTAIVcls.reimplement()
		windowUI.statusLine.setText('<html><head></head><body><p align="center" style="background: solid #9EFF0E;">GTAIV fixed</p></body></html>')
		self.toggleButtons()

	def	EFLCfix(self):
		'''
		Fix EFLC's files.
		'''
		self.toggleButtons()
		EFLCcls.reimplement()
		windowUI.statusLine.setText('<html><head></head><body><p align="center" style="text-align: center; background: solid #9EFF0E;">EFLC fixed</p></body></html>')
		self.toggleButtons()

	def toggleButtons(self):
		'''
		Toggle the state of the buttons, to prevent the user from furiously clicking the buttons and cause unwanted behaviour.
		'''
		if self.buttonsEnabled == True:
			windowUI.findGTAIV.setEnabled(False)
			windowUI.findEFLC.setEnabled(False)
			windowUI.toggle_GTAIV.setEnabled(False)
			windowUI.toggle_EFLC.setEnabled(False)
			windowUI.fixGTAIV.setEnabled(False)
			windowUI.fixEFLC.setEnabled(False)
			self.buttonsEnabled = False
		else:
			windowUI.findGTAIV.setEnabled(True)
			windowUI.findEFLC.setEnabled(True)
			windowUI.toggle_GTAIV.setEnabled(True)
			windowUI.toggle_EFLC.setEnabled(True)
			windowUI.fixGTAIV.setEnabled(True)
			windowUI.fixEFLC.setEnabled(True)
			self.buttonsEnabled = True

	def closeEvent(self, event):
		'''
		Closing event catcher.
		'''
		try:
			with open(r".\log.log", "r+") as f:
				text = f.read(20000)
				f.seek(0)
				f.write(strftime("%Y-%m-%d %H:%M:%S") + " - " + globalID + " - Main - Line 132: App closing... \n" + text)
		except:
			pass


class Game(QtGui.QWidget):
	'''
	Class to contain the game instances
	'''
	def __init__(self, name, initials, paths, log, parent = None):
		'''
		Pass all variables necessary and instanciate the class
		'''
		QtGui.QWidget.__init__(self, parent)
		self.Game = {
		'name' : name,
		'paths' : paths,
		'initials' : initials,
		'cfgPath' : ".\\cfg\\" + initials + "config.cfg",
		'gameDir' : '.\\',
		'gamePath' : "",
		'handPath' : "",
		'backPath' : "",
		'cmPath' : "",
		'backDir' : ".\\bck\\",
		'log' : log,
		'unimplemented' : 'Unimplemented'
		}
		self.Game['backHand'] = self.Game['backDir'] + self.Game['initials'] + "\\handling.dat"
		self.Game['backCm'] = self.Game['backDir'] + self.Game['initials'] + "\\handling_cm.dat"
		self.Game['handDir'] = r"\common\data\handling.dat"
		self.Game['backHand'] = self.Game['backDir'] + self.Game['initials'] + "\\handling.dat"
		self.Game['backCm'] = self.Game['backDir'] + self.Game['initials'] + "\\handling_cm.dat"
		self.Game['handDir'] = r"\common\data\handling.dat"

		if self.Game['initials'] == "EFLC":
			self.TLAD = {
			'initials' : 'TLAD',
			'backHand' : self.Game['backDir'] + "\\TLAD\\handling.dat",
			'backCm' : self.Game['backDir'] + "\\TLAD\\handling_cm.dat",
			'backPath' : "",
			'cmPath' : "",
			'gameDir' : r'.\TLAD'
			}
			self.TBoGT = { 'initials' : 'TBoGT',
			'backHand' : self.Game['backDir'] + "\\TBoGT\\handling.dat",
			'backCm' : self.Game['backDir'] + "\\TBoGT\\handling_cm.dat",
			'backPath' : "",
			'cmPath' : "",
			'gameDir' : r'.\TBoGT'
			}
		self.States = {
		'DISABLED' : "<html><head></head><body><p style=\"color:darkgray\">Disabled</p></body></html>",
		'ACTIVE' : "<html><head></head><body><p style=\"color:black; background: solid #FF9E9E\">Active</p></body></html>",
        'INACTIVE' : "<html><head></head><body><p style=\"color:gray; background: solid #9EFF9E\">Inactive</p></body></html>",
        'NOTFOUND' : "<html><head></head><body><p style=\"color:red; background: solid #CCCCCC\">Not found</p></body></html>",
        'FOUND' : "<html><head></head><body><p style=\"color:green;\">Found</p></body></html>",
		'CORRUPT' : "<html><head></head><body><p style=\"color:#FFB938; background: solid #FFDD9E\">Corrupt</p></body></html>",
		'UNIMPLEMENTED' : "<html><head></head><body><p style=\"color:darkgray\">Unimplemented</p></body></html>"
		}
		self.logger("--------------------------- Initialized ---------------------------")

	def getPath(self, doConfig = True, doReg = False, doInput = True):
		'''
		Attempt to get the path of the game in question.

		Tries all switches that are True.
		1. Stored config file
		2. Registry
		3. User input
		'''
		try: # Test to see if self.pathFound is set
			if self.pathFound == True:
				reply = QtGui.QMessageBox.question(self, \
					'Already found', \
					self.Game['initials'] + " has already been found. Do you want to manually input the path?<br />Cancel returns to the menu.", \
					QtGui.QMessageBox.Yes, \
					QtGui.QMessageBox.No, \
					QtGui.QmessageBox.Cancel)
				if reply == QtGui.QMessageBox.Yes:
					doReg = False
					doConfig = False
					doInput = True
				elif reply == QtGui.QMessageBox.No:
					doReg = True
					doConfig = True
					doInput = True
				elif reply == QtGui.QMessageBox.Cancel:
					doReg = False
					doConfig = False
					doInput = False
		except AttributeError: # If it's not:
			self.pathFound = False
		if doConfig:
			if self.pathFound == False:
				self.readConfig()
		if doReg:
			if self.pathFound == False:
				self.regRead()
		if doInput:
			if self.pathFound == False:
				self.inputPath()
		if self.setPaths():
			self.backupHand()
			if self.checkState() == (self.States['UNIMPLEMENTED'] or self.States['CORRUPT']):
				self.reimplement()
				self.checkState()

	def regRead(self):
		'''
		Read the registry for the path of the game in question, given known places in the registry said path tends to be.

		If the path found is correct, it is stored in the config file, as per the 2nd and 3rd try statements.
		'''
		pass
		"""for regKey in self.Game['paths']:
			self.logger("\n" + regKey)
			try:
				aReg = ConnectRegistry(None,HKEY_LOCAL_MACHINE)
				aKey = OpenKey(aReg, regKey)
				n = { }
				for i in range(1024):
					n['key'],n['value'],n['type'] = EnumValue(aKey,i)
					if n['key'] == ('InstallLocation' or 'InstallFolder'):
						# print(['value'])
						if os.path.exists(n['value'] + self.Game['initials']):
							self.Game['gamePath'] = n['value'] + self.Game['initials']
						elif os.path.exists(n['value']):
							self.Game['gamePath'] = n['value']
						self.pathFound = True
						try:
							with open(self.Game['cfgPath'], "w") as f:
								f.write(self.Game['gamePath'])
						except IOError:
							self.logger("Could not open config file for writing: " + str(e) + " - " + str(sys.exc_info()[0]))
					else:
						self.pathFound = False
				CloseKey(aKey)
				CloseKey(aReg)
				if self.pathFound == True:
					break
			except EnvironmentError as e:
				self.logger("Could not read registry " + str(e) + " - " + str(sys.exc_info()[0]))"""

	def readConfig(self):
		'''
		Try to read the stored config file for the path to the game in question.
		'''
		try:
			with open(self.Game['cfgPath'], "r") as f:
				line = f.readline()
				self.logger("CFG read: " + line)
				if line == self.Game['unimplemented']:
					self.pathFound = True
					self.logger("Config read 'Unimplemented'. Game marked as unimplemented until Found is used.")
				elif self.verifyPath(line):
					self.Game['gamePath'] = line
					self.pathFound = True
		except IOError:
			self.pathFound = False

	def verifyPath(self, _path):
		'''
		Verify the existence of handDir at _path.
		'''
		if os.path.exists(_path + self.Game['handDir']):
			if self.Game['initials'] == "EFLC":
				if os.path.exists(_path + self.TLAD['gameDir']) and os.path.exists(_path + self.TBoGT['gameDir']):
					return True
				else:
					return False
			else:
				return True
		else:
			return False

	def setPaths(self):
		'''
		Sets the working paths for the game (and sub-dlc, if the game in question is EFLC).
		'''
		if self.pathFound == True: #If path has been found, assign paths to handling.dat copies.
			self.Game['handPath'] = self.Game['gamePath'] + r"\common\data\handling.dat"
			self.Game['backPath'] = self.Game['gamePath'] + r"\common\data\backup\handling.dat"
			self.Game['cmPath'] = self.Game['gamePath'] + r"\common\data\cm\handling.dat"
			self.Game['cmFolder'] = self.Game['gamePath'] + r"\common\data\backup"
			self.Game['backFolder'] = self.Game['gamePath'] + r"\common\data\cm"
			if self.Game['initials'] == "EFLC":
				self.TLAD["handPath"] = self.Game['gamePath'] + r"\TLAD\common\data\handling.dat"
				self.TLAD["backPath"] = self.Game['gamePath'] + r"\TLAD\common\data\backup\handling.dat"
				self.TLAD["cmPath"] = self.Game['gamePath'] + r"\TLAD\common\data\cm\handling.dat"
				self.TLAD["backFolder"] = self.Game['gamePath'] + r"\TLAD\common\data\backup"
				self.TLAD["cmFolder"] = self.Game['gamePath'] + r"\TLAD\common\data\cm"

				self.TBoGT["handPath"] = self.Game['gamePath'] + r"\TBoGT\common\data\handling.dat"
				self.TBoGT["backPath"] =  self.Game['gamePath'] + r"\TBoGT\common\data\backup\handling.dat"
				self.TBoGT["cmPath"] = self.Game['gamePath'] + r"\TBoGT\common\data\cm\handling.dat"
				self.TBoGT["backFolder"] = self.Game['gamePath'] + r"\TBoGT\common\data\backup"
				self.TBoGT["cmFolder"] = self.Game['gamePath'] + r"\TBoGT\common\data\cm"
			return True
		else:
			return False

	def inputPath(self):
		'''
		Take input from the user in the form of a directory browsing dialog.

		Previously used a simple text box to accept a copy/pasted input, but that was tedious, especially for me who tests this damn thing 20 times a day to see that it's still holding shape.
		If input path is correct, the path is stored in the config file.
		'''
		global lastFolder
		dialog = QtGui.QFileDialog()
		dialog.AcceptMode = 0
		dialog.FileMode = 2
		dialog.Option = 0x00000020
		dialog.ViewMode = 0
		result = dialog.getExistingDirectory(self, "Find and open the " + self.Game['initials'] + " directory", lastFolder)
		lastFolder = result
		self.logger("Last folder is: " + lastFolder)

		if len(result) > 0: # If the result is not empty
			try:
				while result[:-1] == '\\': # Remove trailing backslashes until there are none left
					result = result[:-1]
			except IndexError:
				pass # No more backslashes

			if self.verifyPath(result):
				self.Game['gamePath'] = result
				self.pathFound = True
				try: # Write to config
					with open(self.Game['cfgPath'], "w") as f:
						f.write(self.Game['gamePath'])
				except IOError as e:
					self.logger("Could not open config file for writing: " + str(e))
		else:
			if self.Game['gamePath'] == "":
				try:
					with open(self.Game['cfgPath'], "w") as f:
						f.write(self.Game['unimplemented'])
				except IOError as e:
					self.logger('Could not open config file for writing: ' + str(e))
				self.logger("User clicked cancel in the file dialog. Game unimplemented")
				self.pathFound = False
			self.logger("User clicked cancel in the file dialog. Game still implemented.")
			self.pathFound = False

	def checkState(self):
		'''
		Checks the state of the game in question and updates the labels accordingly.
		'''
		_ = self.checkStateRun(self.Game)
		if self.Game['initials'] == 'EFLC':
			if self.checkStateDLC(self.TLAD) == self.States['CORRUPT'] or self.checkStateDLC(self.TBoGT) == self.States['CORRUPT']:
				_ = self.States['CORRUPT']
		return _


	def checkStateRun(self, _):
		'''
		State checking function.
		'''
		b, c = os.path.exists(_['backPath']), os.path.exists(_['cmPath'])
		if b and not c:
			self.updateLabel(self.States['ACTIVE'])
			self.logger("Currently ACTIVE.")
			_['state'] = "ACTIVE"
			return self.States['ACTIVE']
		elif not b and c:
			self.updateLabel(self.States['INACTIVE'])
			self.logger("Currently INACTIVE.")
			_['state'] = "INACTIVE"
			return self.States['INACTIVE']
		elif not b and not c:
			self.updateLabel(self.States['UNIMPLEMENTED'])
			self.logger("Currently UNIMPLEMENTED.")
			_['state'] = "UNIMPLEMENTED"
			return self.States['UNIMPLEMENTED']
		elif b and c:
			self.updateLabel(self.States['CORRUPT'])
			self.logger("Currently CORRUPT.")
			_['state'] = "CORRUPT"
			return self.States['CORRUPT']

	def checkStateDLC(self, dlc):
		'''
		Special function to handle checking the DLCs.
		'''
		b, c = os.path.exists(dlc['backPath']), os.path.exists(dlc['cmPath'])
		if b and not c:
			if not self.Game['state'] == "ACTIVE":
				self.updateLabel(self.States['CORRUPT'])
				self.logger("Currently CORRUPT, through checkState DLC")
				self.Game['state'] = "CORRUPT"
				return self.States['CORRUPT']
		if not b and c:
			if not self.Game['state'] == "INACTIVE":
				self.updateLabel(self.States['CORRUPT'])
				self.logger("Currently CORRUPT, through checkState DLC")
				self.Game['state'] = "CORRUPT"
				return self.States['CORRUPT']
		if not b and not c:
			self.updateLabel(self.States['UNIMPLEMENTED'])
			self.logger(dlc['initials'] + " currently UNIMPLEMENTED")
		elif b and c:
			self.updateLabel(self.States['CORRUPT'])
			self.logger(dlc['initials'] + " currently CORRUPT")

	def backupHand(self):
		'''
		Back up the non-carmageddonified handling.dat file.
		'''
		if (os.path.exists(self.Game['backDir']) != True):
			os.makedirs(self.Game['backDir'])

		_state = self.checkState()
		if _state == self.States['INACTIVE']:
			if os.path.exists(self.Game['backHand']) == False:
				shutil.copyfile(self.Game['handPath'], self.Game['backHand'])
			else:
				if filecmp.cmp(self.Game['backHand'], self.Game['handPath']) != True:
					reply = QtGui.QMessageBox.question(self, "Different files", "The " + self.Game['initials'] + "'s handling.dat and the backup taken earlier mismatch. <br />Do you want to overwrite the current backup?", QtGui.QMessageBox.Yes, QtGui.QMessageBox.No)
					if reply == QtGuiMessageBox.Yes:
						shutil.copyfile(self.Game['handPath'], self.Game['backHand'])
						if self.Game['initials'] == "EFLC":
							shutil.copyfile(self.TLAD['handPath'], self.TLAD['backHand'])
							shutil.copyfile(self.TBoGT['handPath'], self.TBoGT['backHand'])
		elif _state == self.States['ACTIVE']:
			if os.path.exists(self.Game['backHand']) == False:
				shutil.copyfile(self.Game['backPath'], self.Game['backHand'])
			else:
				if filecmp.cmp(self.Game['backPath'], self.Game['backHand']) != True:
					reply = QtGui.QMessageBox.question(self, "Different files", "The " + self.Game['initials'] + "'s handling.dat and the backup taken earlier mismatch. <br />Do you want to overwrite the current backup?", QtGui.QMessageBox.Yes, QtGui.QMessageBox.No)
					if reply == QtGuiMessageBox.Yes:
						shutil.copyfile(self.Game['backPath'], self.Game['backHand'])
						if self.Game['initials'] == "EFLC":
							shutil.copyfile(self.TLAD['backPath'], self.TLAD['backHand'])
							shutil.copyfile(self.TBoGT['backPath'], self.TBoGT['backHand'])
		else:
			#QtGui.QMessageBox.about(self, 'Corrupt installation', "Files're completely awry. Re-implementing all files freshly now.<br />Funkiness factor: 33")
			self.reimplement()
			self.logger("Reimplemented " + self.Game['initials'] + " due to corrupt or unimplemeted installation found in backupHand")

	def reimplement(self):
		'''
		Call the subroutine reimplementing the games.
		'''
		if self.Game['gamePath'] != "":
			try:
				self.reimplementRun(self.Game)
				if self.Game['initials'] == "EFLC":
					self.reimplementRun(self.TLAD)
					self.reimplementRun(self.TBoGT)
				self.logger("Reimplemented " + self.Game['initials'])
				self.checkState()
			except AttributeError as e:
				self.logger("Unable to reimplement: " + str(sys.exc_info()[0]) + ": " + str(e))



	def reimplementRun(self, dlc):
		'''
		Reimplement all Carmageddon files to the inactive state.
		'''
		try:
			try:
				shutil.rmtree(dlc['backFolder'])
				self.logger("Removed " + dlc['initials'] + "backFolder")
			except OSError as e:
				self.logger("Couldn't remove " + dlc['initials'] + "backFolder: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				shutil.rmtree(dlc['cmFolder'])
				self.logger("Removed " + dlc['initials'] + "cmFolder")
			except OSError as e:
				self.logger("Couldn't remove " + dlc['initials'] + "cmFolder: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				os.remove(dlc['handPath'])
				self.logger("Removed " + dlc['initials'] + "handPath")
			except OSError as e:
				self.logger("Couldn't remove " + dlc['initials'] + "handPath: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				os.mkdir(dlc['backFolder'])
				self.logger("Made " + dlc['initials'] + "backFolder")
			except OSError as e:
				self.logger("Couldn't make " + dlc['initials'] + "backFolder: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				os.mkdir(dlc['cmFolder'])
				self.logger("Made " + dlc['initials'] + "cmFolder")
			except OSError as e:
				self.logger("Couldn't make " + dlc['initials'] + "cmFolder: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				shutil.copyfile(dlc['backHand'], dlc['handPath'])
				self.logger("Copied " + dlc['initials'] + "backHand to " + dlc['initials'] + "handPath")
			except OSError as e:
				self.logger("Couldn't copy " + dlc['initials'] + "backHand to " + dlc['initials'] + "handPath: " + str(e) + " - " + str(sys.exc_info()[0]))
			try:
				shutil.copyfile(dlc['backCm'], dlc['cmPath'])
				self.logger("Copied " + dlc['initials'] + "backCm to " + dlc['initials'] + "cmPath")
			except OSError as e:
				self.logger("Couldn't copy " + dlc['initials'] + "backCm to " + dlc['initials'] + "cmPath: " + str(e) + " - " + str(sys.exc_info()[0]))
		except OSError as e:
			self.logger("Error: " + str(e) + " - " + str(sys.exc_info()[0]))

	def updateLabel(self, _text):
		'''
		Updates the label in the Qt widget correspondingly.
		'''
		_ = "windowUI.status_" + self.Game['initials'] + ".setText(_text)"
		exec(_)
		_ = "windowUI.status_" + self.Game['initials'] + ".repaint()"
		exec(_)

	def toggleState(self):
		'''
		Toggles the state of the Carmageddon mod for the selected game.
		'''
		_state = self.checkState()
		if _state == self.States['ACTIVE']:
			try:
				shutil.move(self.Game['handPath'], self.Game['cmPath'])
				self.logger("Moved handPath to cmPath")
			except OSError as e:
				self.logger("Could not move handPath to cmPath: " + str(e))
			try:
				shutil.move(self.Game['backPath'], self.Game['handPath'])
				self.logger("Moved backPath to handPath")
			except OSError as e:
				self.logger("Could not move backPath to handPath: " + str(e))
			if self.Game['initials'] == "EFLC":
				self.toggleDLC(self.TLAD, self.States['ACTIVE'])
				self.toggleDLC(self.TBoGT, self.States['ACTIVE'])
		elif _state == self.States['INACTIVE']:
			try:
				shutil.move(self.Game['handPath'], self.Game['backPath'])
				self.logger("Moved handPath to backPath")
			except OSError as e:
				self.logger("Could not move handPath to cmPath: " + str(e))
			try:
				shutil.move(self.Game['cmPath'], self.Game['handPath'])
				self.logger("Moved cmPath to handPath")
			except OSError as e:
				self.logger("Could not move cmPath to handPath: " + str(e))
			if self.Game['initials'] == "EFLC":
				self.toggleDLC(self.TLAD, self.States['INACTIVE'])
				self.toggleDLC(self.TBoGT, self.States['INACTIVE'])
		self.checkState()

	def toggleDLC(self, dlc, state):
		'''
		Special toggle function to handle toggling the DLCs.
		'''
		self.logger(dlc['initials'])
		if state == self.States['INACTIVE']:
			try:
				shutil.move(dlc['handPath'], dlc['backPath'])
				self.logger("Moved " + dlc['initials'] + "handPath to " + dlc['initials'] + "backPath")
			except OSError as e:
				self.logger("Could not move " + dlc['initials'] + "handPath to " + dlc['initials'] + "backPath: " + str(e) + str(sys.exc_info()[0]))
			try:
				shutil.move(dlc['cmPath'], dlc['handPath'])
				self.logger("Moved " + dlc['initials'] + "cmPath to " + dlc['initials'] + "handPath")
			except OSError as e:
				self.logger("Could not move " + dlc['initials'] + "cmPath to " + dlc['initials'] + "handPath: " + str(e) + str(sys.exc_info()[0]))
		elif state == self.States['ACTIVE']:
			try:
				shutil.move(dlc['handPath'], dlc['cmPath'])
				self.logger("Moved " + dlc['initials'] + "handPath to " + dlc['initials'] + "cmPath")
			except OSError as e:
				self.logger("Could not move " + dlc['initials'] + "handPath to " + dlc['initials'] + "cmPath: " + str(e) + str(sys.exc_info()[0]))
			try:
				shutil.move(dlc['backPath'], dlc['handPath'])
				self.logger("Moved " + dlc['initials'] + "backPath to " + dlc['initials'] + "handPath")
			except OSError as e:
				self.logger("Could not move " + dlc['initials'] + "backPath to " + dlc['initials'] + "handPath: " + str(e) + str(sys.exc_info()[0]))
	def logger(self, msg):
		'''
		Logs the msg to the log file with a timestamp and the current game initials.
		'''
		frame, filename, line_number, function_name, lines, index = inspect.getouterframes(inspect.currentframe())[1]
		#	line_number = sys.exc_traceback.tb_lineno
		#exc_type, exc_obj, exc_tb = sys.exc_info()
		if not os.path.exists(self.Game['log']):
			with open(self.Game['log'], 'w') as f:
				pass
		with open(self.Game['log'], "r+") as f:
			text = f.read(20000)
			f.seek(0)
			f.write(strftime("%Y-%m-%d %H:%M:%S") + " - " + globalID + " - " + self.Game['initials'] + " - Line " + str(line_number) + ": " + msg + "\n" + text)

if __name__ == "__main__":
	globalID = str(uuid1())
	app = QtGui.QApplication(sys.argv)
	myapp = MainWindow()
	myapp.show()
	sys.exit(app.exec_())