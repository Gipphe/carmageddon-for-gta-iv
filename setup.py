from cx_Freeze import setup, Executable

build_options = {
'includes': ['re', 'atexit', 'icons_rc'],
'include_files': [ r'.\bck', r'.\cfg'],
'packages': [],
'excludes': ['tkinter', 'ctypes', 'lzma', 'bz2'],
'include_msvcr': [ '.\libs\vcredist_x86.exe' ]
}

Exet = Executable(
	script = 'main.py',
	initScript = None,
	base = 'Win32GUI',
	targetName = 'Carmageddon.exe',
	compress = True,
	copyDependentFiles = True,
	appendScriptToExe = False,
	appendScriptToLibrary = False,
	icon = 'CmIcon.ico'
)

setup(
	name = 'Carmageddon Mod',
	version = '3.0.1.1',
	author = 'Gipphe',
	description = 'Carmageddon Mod',
	options = {'build_exe': build_options}, executables = [Exet]
)