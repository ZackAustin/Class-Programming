# Delegation-style object-based delegation
# Illustrates hasattr and getattr and the message passing paradigm

class Object(object):
	def __init__(self):
		self.delegate = None
		
	def send(self, msg, *parms):
		if hasattr(self, msg):
			f = getattr(self, msg)
			return f(self, *parms)	# Plain function call
		else:
			if not self.delegate:
				raise Exception, 'no such message: ' + msg
			return self.delegate.send(msg, *parms)	# Defer to delegate
			
	def set_delegate(self, delegate):
		assert(isinstance(delegate,Object))
		self.delegate = delegate
		
	def clone(self):
		return copy.deepcopy(self)

x = Object()
x.data = []

# Add "methods" to the object x
x.hasMore = lambda this: len(this.data) != 0
x.push = lambda this, a: this.data.append(a)
x.pop = lambda this: this.data.pop()
print vars(x)

# Make x y's prototype
y = Object()
y.set_delegate(x)
print vars(y)

# y delegates to x...
print y.send("hasMore")
y.send("push",1)
print y.send("hasMore")
val = y.send("pop")
print val
print y.send("hasMore")
y.send("push",2)
y.pop = None
#val = y.send("pop")
print vars(y)

""" Output:
{'push': <function <lambda> at 0x7e6b0>, 'hasMore': <function <lambda> at 0x7e6f0>, 'data': [], 'delegate': None, 'pop': <function <lambda> at 0x7e730>}
{'delegate': <__main__.Object object at 0x82d10>}
False
True
1
False
{'delegate': <__main__.Object object at 0x82d10>, 'pop': None}
"""