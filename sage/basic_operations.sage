def bits1(n):
    b = []
    while n:
        b = [n & 1] + b
        n >>= 1
    return b or [0]
    
def binatodeci(binary):
    return sum(val*(2**idx) for idx, val in enumerate(reversed(binary)))

def add_poly (a, b):           
    # Exclusive OR operation of polynomials presented as list of coefficients
    # If inputs are 'int' or 'sage.rings.integer.Integer', returns a list of binary digits (MSB is the 0th element of list)
    if (type (a) == int or type (a) == sage.rings.integer.Integer):
        a_bin = Integer(a).digits(2)[::-1]
    else:
        a_bin = a
    if (type (b) == int or type (b) == sage.rings.integer.Integer):
        b_bin = Integer(b).digits(2)[::-1]
    else:
        b_bin = b
    
    # Length of 'result' list = maximum of input's length
    # Equalize the length of input's lists
    # Notice that insert '0' (MSB) digit at the begining of list 
    len_max = max(len(a_bin),len(b_bin))
    if (len(a_bin) > len(b_bin)):
        while (len_max - len(b_bin) != 0): b_bin.insert(0,0)
    else:
        while (len_max - len(a_bin) != 0): a_bin.insert(0,0)
            
    # Exclusive OR operation
    result = []
    while (len_max > 0):
        result.insert(0,a_bin [len_max - 1] ^^ b_bin [len_max - 1])        
        len_max = len_max - 1
    return result

def mul_poly (a,b,r):
    # Montgomery Multiplication for Integers a and b, modulus r in list form
    # If inputs are 'int' or 'sage.rings.integer.Integer', returns a list of binary digits (MSB is the 0th element of list)
    if (a == 0 or b == 0):
        accu = [0]
    else:
        if (type (a) == int or type (a) == sage.rings.integer.Integer):
            a_ls = Integer(a).digits(2)[::-1]
        else:
            a_ls = a
        if (type (b) == int or type (b) == sage.rings.integer.Integer):
            b_ls = Integer(b).digits(2)[::-1]
        else:
            b_ls = b

        # Length of 'result' list = maximum of input's length
        # Equalize the length of input's lists
        # Notice that insert '0' (MSB) digit at the begining of list 
        bit_len = len(r)-1
        while (len(r)-1 - len(b_ls) != 0): b_ls.insert(0,0)
        while (len(r)-1 - len(a_ls) != 0): a_ls.insert(0,0)

        accu =[]
        for i in range (bit_len):
            if (a_ls[bit_len - 1 - i] == 1):
                accu = add_poly(accu, b_ls)
            if (bool(accu) == True):
                if (accu[len(accu)-1] == 1):
                    accu = add_poly(accu, r)
                accu = accu[:-1]
    
    return hex(binatodeci(accu)).upper()[2:]