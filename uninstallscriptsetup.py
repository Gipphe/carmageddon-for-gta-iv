from cx_Freeze import setup, Executable

build_options = {
'includes': ['re', 'atexit'],
'include_files': [],
'packages': [],
'excludes': ['tkinter', 'ctypes', 'lzma', 'bz2', 'hashlib', 'QtGui4', 'QtCore4', 'Python33', 'PyQt4.QtGui', 'PyQt4.QtCore', 'sip', 'unicodedata', 'BUILD_CONSTANTS', '_osx_support', 'contextlib', 'fnmatch', 'gzip', 'py_compile', 'random', 'shutil', 'sre_compile', 'sre_constants', 'sre_parse', 'tarfile', 'tempfile', 'zipfile', 'distutils'],
'include_msvcr': []
}

Exet = Executable(
	script = 'uninstallscript.py',
	initScript = None,
	base = 'Win32GUI',
	targetName = 'uninstallscript.exe',
	compress = True,
	copyDependentFiles = True,
	appendScriptToExe = False,
	appendScriptToLibrary = False,
)

setup(
	name = 'Uninstall script',
	version = '1.1',
	author = 'Gipphe',
	description = 'Uninstaller script for Carmageddon Mod',
	options = {'build_exe': build_options}, executables = [Exet]
)