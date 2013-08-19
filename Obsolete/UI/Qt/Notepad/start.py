import sys
from PyQt4 import QtCore, QtGui
from notepad import Ui_notepad

class StartQT4(QtGui.QMainWindow):
	def __init__(self, parent=None):
		QtGui.QWidget.__init__(self, parent)
		self.ui = Ui_notepad()
		self.ui.setupUi(self)
		# here we connect signals with our slots
		QtCore.QObject.connect(self.ui.button_open,QtCore.SIGNAL("clicked()"), self.file_dialog)
		QtCore.QObject.connect(self.ui.button_save,QtCore.SIGNAL("clicked()"), self.file_save)
		QtCore.QObject.connect(self.ui.editor_window,QtCore.SIGNAL("textChanged()"), self.enable_save)

	def file_save(self):
		sf = QtGui.QFileDialog(self)
		self.filename = sf.getSaveFileName()
		from os.path import isfile
		if self.filename:
			import codecs
			file = codecs.open(self.filename,'w','utf-8')
			file.write(unicode(self.ui.editor_window.toPlainText()))
			file.close()
			self.ui.button_save.setEnabled(False)
			
	def enable_save(self):
		self.ui.button_save.setEnabled(True)	

	def file_dialog(self):
		response = False
		# buttons texts
		SAVE = 'Save'
		DISCARD = 'Discard'
		CANCEL = 'Cancel'
		# if we have changes then ask about them
		if self.ui.button_save.isEnabled() and self.filename:
			message = QtGui.QMessageBox(self)
			message.setText('What to do about unsaved changes ?')
			message.setWindowTitle('Notepad')
			message.setIcon(QtGui.QMessageBox.Warning)
			message.addButton(SAVE, QtGui.QMessageBox.AcceptRole)
			message.addButton(DISCARD, QtGui.QMessageBox.DestructiveRole)
			message.addButton(CANCEL, QtGui.QMessageBox.RejectRole)
			message.setDetailedText('Unsaved changes in file: ' + str(self.filename))
			message.exec_()
			response = message.clickedButton().text()
			# save  file
			if response == SAVE:
				self.file_save()
				self.ui.button_save.setEnabled(False)
			# discard changes
			elif response == DISCARD:
				self.ui.button_save.setEnabled(False)
		# if we didn't cancelled show the file dialogue
		if response != CANCEL:
			fd = QtGui.QFileDialog(self)
			self.filename = fd.getOpenFileName()
			from os.path import isfile
			if isfile(self.filename):
				import codecs
				s = codecs.open(self.filename,'r','utf-8').read()
				self.ui.editor_window.setPlainText(s)
				self.ui.button_save.setEnabled(False)
		
if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	myapp = StartQT4()
	myapp.show()
	sys.exit(app.exec_())