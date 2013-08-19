'''
Removes the cm and backup dirs from the data folder.
'''
import sys, os, shutil
from PyQt4 import QtCore, QtGui

class MainWindow(QtGui.QMainWindow):
	def __init__(self, parent=None):
		QtGui.QWidget.__init__(self, parent)
		GTAIV = Game("GTAIV")
		EFLC = Game("EFLC")
		QtGui.QMessageBox.about(self, "Uninstalling", "Removed all Carmageddon-related files.")
class Game(QtGui.QWidget):
	def __init__(self, initials, parent=None):
		QtGui.QWidget.__init__(self, parent)
		self.Game = {
		'initials' : initials,
		'cfgPath' : ".\\cfg\\" + initials + "config.cfg"
		}
		if os.path.isfile(self.Game['cfgPath']):
			with open(self.Game['cfgPath'], "r") as f:
				self.Game['gamePath'] = f.readline()
				self.Game['handPath'] = self.Game['gamePath'] + r"\common\data\handling.dat"
				self.Game['backPath'] = self.Game['gamePath'] + r"\common\data\backup\handling.dat"
				self.Game['cmPath'] = self.Game['gamePath'] + r"\common\data\cm\handling.dat"
				self.Game['cmFolder'] = self.Game['gamePath'] + r"\common\data\backup"
				self.Game['backFolder'] = self.Game['gamePath'] + r"\common\data\cm"
				print(self.Game['cmFolder'])
				if self.Game['initials'] == "EFLC":
					self.TLAD = {}
					self.TBoGT = {}

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
			self.removestuff(self.Game)
			if self.Game['initials'] == "EFLC":
				self.removestuff(self.TLAD)
				self.removestuff(self.TBoGT)
		else:
			QtGui.QMessageBox.about(self, "Uninstalling", "Config file not found for " + self.Game['initials'] + ". Assuming you never started the Carmageddon Mod or that you don't have " + self.Game['cfgPath'] + " on your computer.")

	def removestuff(self, vals):
		b, c = os.path.isfile(vals['backPath']), os.path.isfile(vals['cmPath'])
		if b and not c:
			try:
				shutil.move(vals['backPath'], vals['handPath'])
			except:
				pass
			try:
				shutil.rmtree(vals['backFolder'])
			except:
				pass
			try:
				shutil.rmtree(vals['cmFolder'])
			except:
				pass

		elif not b and c:
			try:
				shutil.rmtree(vals['backFolder'])
			except:
				pass
			try:
				shutil.rmtree(vals['cmFolder'])
			except:
				pass

if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	myapp = MainWindow()
	sys.exit(app.exec_())
