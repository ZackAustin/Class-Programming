# Try n = 35
# fib2 and fib3 seem to be comparable
# Execute: python -m cProfile fib.py

def fib(n):
    if n in [0,1]: return n
    return fib (n-1) + fib (n-2)

def fib2(n):
    def fibhelp(n,a,b):
        return fibhelp(n-1,a+b,a) if n > 0 else a
    return fibhelp (n,0,1)

def fib3(n):
    if n in [0,1]: return n
    last,current = 0,1
    for x in xrange(2,n+1):
        last,current = current, last+current
    return current

print fib(35)
print fib2(35)
print fib3(35)
