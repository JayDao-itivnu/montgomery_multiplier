def bits1(n):
    b = []
    while n:
        b = [n & 1] + b
        n >>= 1
    return b or [0]

import os
import basic_operations
# Get environment variables
sim_dir = os.getenv('SIM_DIR')
test_file = os.getenv('DESIGN_NAME') + (".txt")
filename = os.path.join(sim_dir, test_file)
r = bits1(int("0x800000000000000000000000000000000000000C9", 16));
len_of_bit = 163
no_of_test =  50000
 
file = open(filename,"w")
for i in range(no_of_test) :
    a = randint(0,2^len_of_bit - 1); 
    if (a == 0):
        a_ls = [0]
    else:
        a_ls = Integer(a).digits(2)[::-1]
    b = randint(0,2^len_of_bit - 1); 
    if (b == 0):
        b_ls = [0]
    else:
        b_ls = Integer(b).digits(2)[::-1]
    if (len(a_ls) < len_of_bit):
        while (len_of_bit - len(a_ls) != 0): a_ls.insert(0,0)
    if (len(b_ls) < len_of_bit):
        while (len_of_bit - len(b_ls) != 0): b_ls.insert(0,0)
    file.write("N="); file.write(str(i+1))
    file.write("\nA=")
    file.write("{0:0>2}".format(hex(a).upper()[2:]))
    
    file.write("\nB=")
    file.write("{0:0>2}".format(hex(b).upper()[2:]))
    print ("complete", i,"/",no_of_test);
    result_ls = basic_operations.mul_poly(a_ls,b_ls,r)
    result = result_ls.zfill((len_of_bit+1)/4) 
    file.write("\nC=")
    file.write(result)
    file.write("\n")
file.close()
