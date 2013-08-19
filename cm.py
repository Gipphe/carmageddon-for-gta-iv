# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'carmageddon.ui'
#
# Created: Tue Sep 17 15:15:55 2013
#      by: PyQt4 UI code generator 4.10.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_CmMain(object):
    def setupUi(self, CmMain):
        CmMain.setObjectName(_fromUtf8("CmMain"))
        CmMain.resize(180, 286)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(CmMain.sizePolicy().hasHeightForWidth())
        CmMain.setSizePolicy(sizePolicy)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8(":/CmIcon.ico")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        CmMain.setWindowIcon(icon)
        self.centralwidget = QtGui.QWidget(CmMain)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.centralwidget.sizePolicy().hasHeightForWidth())
        self.centralwidget.setSizePolicy(sizePolicy)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralwidget)
        self.gridLayout.setSizeConstraint(QtGui.QLayout.SetFixedSize)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.status_GTAIV = QtGui.QLabel(self.centralwidget)
        self.status_GTAIV.setObjectName(_fromUtf8("status_GTAIV"))
        self.gridLayout.addWidget(self.status_GTAIV, 3, 0, 1, 3)
        self.toggle_GTAIV = QtGui.QPushButton(self.centralwidget)
        self.toggle_GTAIV.setObjectName(_fromUtf8("toggle_GTAIV"))
        self.gridLayout.addWidget(self.toggle_GTAIV, 9, 0, 1, 3)
        spacerItem = QtGui.QSpacerItem(0, 10, QtGui.QSizePolicy.Minimum, QtGui.QSizePolicy.Fixed)
        self.gridLayout.addItem(spacerItem, 8, 1, 1, 1)
        self.toggle_EFLC = QtGui.QPushButton(self.centralwidget)
        self.toggle_EFLC.setObjectName(_fromUtf8("toggle_EFLC"))
        self.gridLayout.addWidget(self.toggle_EFLC, 10, 0, 1, 3)
        self.findGTAIV = QtGui.QPushButton(self.centralwidget)
        self.findGTAIV.setObjectName(_fromUtf8("findGTAIV"))
        self.gridLayout.addWidget(self.findGTAIV, 11, 0, 1, 1)
        self.close_button = QtGui.QPushButton(self.centralwidget)
        self.close_button.setObjectName(_fromUtf8("close_button"))
        self.gridLayout.addWidget(self.close_button, 13, 0, 1, 3)
        self.line = QtGui.QFrame(self.centralwidget)
        self.line.setFrameShape(QtGui.QFrame.HLine)
        self.line.setFrameShadow(QtGui.QFrame.Sunken)
        self.line.setObjectName(_fromUtf8("line"))
        self.gridLayout.addWidget(self.line, 7, 0, 2, 3)
        self.status_EFLC = QtGui.QLabel(self.centralwidget)
        self.status_EFLC.setObjectName(_fromUtf8("status_EFLC"))
        self.gridLayout.addWidget(self.status_EFLC, 6, 0, 1, 3)
        self.label_EFLC = QtGui.QLabel(self.centralwidget)
        self.label_EFLC.setObjectName(_fromUtf8("label_EFLC"))
        self.gridLayout.addWidget(self.label_EFLC, 5, 0, 1, 2)
        self.line_2 = QtGui.QFrame(self.centralwidget)
        self.line_2.setEnabled(True)
        self.line_2.setFrameShape(QtGui.QFrame.HLine)
        self.line_2.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_2.setObjectName(_fromUtf8("line_2"))
        self.gridLayout.addWidget(self.line_2, 4, 0, 1, 3)
        self.label_GTAIV = QtGui.QLabel(self.centralwidget)
        self.label_GTAIV.setObjectName(_fromUtf8("label_GTAIV"))
        self.gridLayout.addWidget(self.label_GTAIV, 2, 0, 1, 3)
        self.findEFLC = QtGui.QPushButton(self.centralwidget)
        self.findEFLC.setObjectName(_fromUtf8("findEFLC"))
        self.gridLayout.addWidget(self.findEFLC, 11, 2, 1, 1)
        self.fixGTAIV = QtGui.QPushButton(self.centralwidget)
        self.fixGTAIV.setObjectName(_fromUtf8("fixGTAIV"))
        self.gridLayout.addWidget(self.fixGTAIV, 12, 0, 1, 1)
        self.fixEFLC = QtGui.QPushButton(self.centralwidget)
        self.fixEFLC.setObjectName(_fromUtf8("fixEFLC"))
        self.gridLayout.addWidget(self.fixEFLC, 12, 2, 1, 1)
        self.statusLine = QtGui.QLabel(self.centralwidget)
        self.statusLine.setObjectName(_fromUtf8("statusLine"))
        self.gridLayout.addWidget(self.statusLine, 0, 0, 1, 3)
        self.line_3 = QtGui.QFrame(self.centralwidget)
        self.line_3.setFrameShape(QtGui.QFrame.HLine)
        self.line_3.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_3.setObjectName(_fromUtf8("line_3"))
        self.gridLayout.addWidget(self.line_3, 1, 0, 1, 3)
        CmMain.setCentralWidget(self.centralwidget)

        self.retranslateUi(CmMain)
        QtCore.QObject.connect(self.close_button, QtCore.SIGNAL(_fromUtf8("clicked()")), CmMain.close)
        QtCore.QMetaObject.connectSlotsByName(CmMain)

    def retranslateUi(self, CmMain):
        CmMain.setWindowTitle(_translate("CmMain", "Carmageddon", None))
        self.status_GTAIV.setText(_translate("CmMain", "<html><head/><body><p>Checking status...</p></body></html>", None))
        self.toggle_GTAIV.setText(_translate("CmMain", "Toggle GTA IV", None))
        self.toggle_EFLC.setText(_translate("CmMain", "Toggle EFLC", None))
        self.findGTAIV.setToolTip(_translate("CmMain", "<html><head/><body><p>Click to manually specify GTAIV\'s path</p></body></html>", None))
        self.findGTAIV.setText(_translate("CmMain", "Find GTAIV", None))
        self.close_button.setText(_translate("CmMain", "Close", None))
        self.status_EFLC.setText(_translate("CmMain", "<html><head/><body><p>Checking status...</p></body></html>", None))
        self.label_EFLC.setText(_translate("CmMain", "<html><head/><body><p>EFLC:</p></body></html>", None))
        self.label_GTAIV.setText(_translate("CmMain", "<html><head/><body><p>GTA IV:</p></body></html>", None))
        self.findEFLC.setToolTip(_translate("CmMain", "<html><head/><body><p>Click to manually specify EFLC\'s path</p></body></html>", None))
        self.findEFLC.setText(_translate("CmMain", "Find EFLC", None))
        self.fixGTAIV.setToolTip(_translate("CmMain", "<html><head/><body><p>Click to reimplement all Carmageddon files for GTAIV. Useful if you know something\'s off while Carmageddon Mod doesn\'t notice it itself.</p></body></html>", None))
        self.fixGTAIV.setText(_translate("CmMain", "Fix GTAIV", None))
        self.fixEFLC.setToolTip(_translate("CmMain", "<html><head/><body><p>Click to reimplement all Carmageddon files for EFLC. Useful if you know something\'s off while Carmageddon Mod doesn\'t notice it itself.</p></body></html>", None))
        self.fixEFLC.setText(_translate("CmMain", "Fix EFLC", None))
        self.statusLine.setText(_translate("CmMain", "<html><head/><body><p align=\"center\">Ready</p></body></html>", None))

import icons_rc
