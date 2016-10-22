def memo(f):
   "A memoizing decorator"
   def wrapper(*args):
      if args in wrapper.cache:
         print "found in cache" # trace to prove caching
         return wrapper.cache[args]
      else:
         wrapper.cache[args] = value = f(*args)
         return value
   wrapper.cache = {}	# could also be an attribute of f instead
   return wrapper

@memo
def f(a,b):
    return a*b

print f(2,3)
print f(2,3)
print f('a',3)
print f('a',3)

""" Output:
6
found in cache
6
aaa
found in cache
aaa
"""
