# virtinit.py

# See http://chandlerproject.org/Projects/UsingSuper

class A(object):
    def __init__(self):
        super(A,self).__init__()    # Must do this at the top level!
        print "A"
class B(object):
    def __init__(self):
        super(B,self).__init__()
        print "B"
class C(object):
    def __init__(self):
        super(C,self).__init__()
        print "C"
class D(object):
    def __init__(self):
        super(D,self).__init__()
        print "D"

class E(A,B,C):
    def __init__(self):
        super(E,self).__init__()
        print "E"
class F(B,C,D):
    def __init__(self):
        super(F,self).__init__()
        print "F"

E()
print
F()
print

class G(E,F):
    def __init__(self):
        super(G,self).__init__()
        print "G"

G()

""" Output:
C
B
A
E

D
C
B
F

D
C
B
F
A
E
G
"""