from memo import *

def exc(g):
    print g()
    print g()

exc(memo(lambda : "hello"))

""" Output:
hello
found in cache
hello
"""