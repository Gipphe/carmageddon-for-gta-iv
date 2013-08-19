@echo off
start pyrcc4 -py3 icons.qrc -o icons_rc.py
pyuic4 carmageddon.ui > cm.py