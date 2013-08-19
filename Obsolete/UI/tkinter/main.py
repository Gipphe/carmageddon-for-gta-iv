from tkinter import *
from os import *

class App:

	def __init__(self, master):

		frame = Frame(master)
		frame.pack()

		self.var = StringVar()
		self.var.set = "Hello"

		titleLabel = Label(frame, textvariable=self.var)
		cb = Checkbutton(frame, text="Checkbutton")
		hithere = Button(frame, text="button", command=titlechange)
		quitButton = Button(frame, text="Quit", fg="red")

		titleLabel.grid(column=0, row=0, columnspan=2)
		cb.grid(row=1, columnspan=2, sticky=W)
		hithere.grid(row=2, column=0, sticky=W)
		quitButton.grid(row=2, column=1, sticky=W)
	
	def say_hi(self):
		print("hi there, everyone!")
	def titlechange(self):
		self.var.set = "World"
		

root = Tk()

app = App(root)

root.mainloop()
