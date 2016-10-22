# Implementing reduce imperatively in Python

import operator

def reduce(f,seed,elems):
    result = seed;
    for elem in reversed(elems):
        result = f(elem,result)
    return result
    
x = [1,2,3,4]
print reduce(operator.add,0,x)  # 10
print reduce(operator.mul,1,x)  # 24
