# Counter Program using a class

# In Python, the "this pointer" is visible (usually called "self"). At first this seems strange,
# but it turns out to a tremendous simplification. Trust me! Bindings are second nature from the
# very beginning in Python.

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

actions = [Counter.incrCounter, Counter.decrCounter, Counter.displayCounter, Counter.resetCounter]
theCounter = Counter()	
while True:
	choice = prompt()-1
	if choice in range(len(actions)):
		actions[choice](theCounter)		# Shows the beauty of self!
	elif choice == len(actions):
		break
	else:
		print "error"
		
		
