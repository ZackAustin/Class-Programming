# Counter Program

# In Python, variables are created when they're first bound (you don't "declare" them)
# For this reason, the only variables you have to decalre are global variables,
# and then only when you're going to modfy them. Snce this is exceptional, there is less
# noise overall in typical Python programs

# Note: "def" defines functions. Indentation is required (a good thing!)

import os	# For clearing the screen
counter = 0

def resetCounter():
	global counter
	counter = 0
	
def incrCounter():
	global counter
	counter += 1
	
def decrCounter():
	global counter
	counter -= 1
	
def displayCounter():
	print "The value of the counter is", counter

def prompt():
	print "Counter Program..."
	print "Select from the following options: Type"
	print "1 to increment the counter"
	print "2 to decrement the counter"
	print "3 to display the counter"
	print "4 to reset the counter"
	print "5 to exit"
	choice = input()
	os.system("clear")	# I'm using Mac OS X
	return choice

actions = [incrCounter, decrCounter, displayCounter, resetCounter]
	
while True:
	choice = prompt()-1
	if choice in range(len(actions)):
		actions[choice]()
	elif choice == len(actions):
		break
	else:
		print "error"
