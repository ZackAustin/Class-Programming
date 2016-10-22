# Counter Program using bound methods

import os	# For clearing the screen

class Counter():
	def __init__(self):		# A constructor
		self.counter = 0
	def resetCounter(self):
		self.counter = 0
	def incrCounter(self):
		self.counter += 1
	def decrCounter(self):
		self.counter -= 1
	def displayCounter(self):
		print "The value of the counter is", self.counter

def prompt():
	print "Counter Program..."
	print "Select from the following options: Type"
	print "1 to increment the counter"
	print "2 to decrement the counter"
	print "3 to display the counter"
	print "4 to reset the counter"
	print "5 to exit"
	choice = input()
	os.system("clear")	# I'm using Mac OS X; use "cls" on Windows
	return choice

theCounter = Counter()	
actions = [theCounter.incrCounter, theCounter.decrCounter, theCounter.displayCounter, theCounter.resetCounter]
while True:
	choice = prompt()-1
	if choice in range(len(actions)):
		actions[choice]()
	elif choice == len(actions):
		break
	else:
		print "error"
		
		
