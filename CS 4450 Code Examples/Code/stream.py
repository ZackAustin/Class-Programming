def newton_sqrt(a,x0):
    xi = x0
    while True:
        x = (xi + a/xi) / 2
        yield x
        xi = x

def iterate(stream, eps):
    last = stream.next()
    current = stream.next()
    while (abs(current-last) > eps):
        last = current
        current = stream.next()
    return current

gen = newton_sqrt(2.0, 2.0)
print iterate(gen, .000000001)

""" Output:
1.41421356237
"""

def intsfrom(k):
    while True:
        yield k
        k += 1
        
def takeodd(stream):
    while True:
        n = stream.next()
        while n % 2 == 0:
            n = stream.next()
        yield n

def streamsum(stream):
    accum = 0
    while True:
        accum += stream.next()
        yield accum

# Compose streams:        
squares = streamsum(takeodd(intsfrom(1)))

for n in xrange(10): print squares.next()

""" Output:
1
4
9
16
25
36
49
64
81
100
"""

def expterm(x):
    num = 1.0
    den = 1.0
    n = 0
    accum = 0.0
    while True:
        accum += num/den
        yield accum
        num  *= x
        n += 1
        den *= n
        
def myexp(x, eps):
    return iterate(expterm(x), eps)
    
print myexp(1.0, 0.00000001)
print myexp(2.0, 0.00000001)

""" Output:
2.71828182829
7.38905609852
"""