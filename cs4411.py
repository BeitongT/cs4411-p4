#! /usr/bin/env python
import sys
import numpy as np
import matplotlib.pyplot as plt

with open(sys.argv[1]) as fS:
    contentS = fS.readlines()
with open(sys.argv[2]) as fR:
    contentR = fR.readlines()
with open(sys.argv[3]) as fI:
    contentI = fI.readlines()

contentS = [int(x.strip()) for x in contentS] 
contentR = [int(x.strip()) for x in contentR] 
contentI = [int(x.strip()) for x in contentI] 
print(contentS)
print(contentR)
print(contentI)
contentS = np.asarray(contentS)
contentR = np.asarray(contentR)
contentI = np.asarray(contentI)
start = int(sys.argv[4])
end = int(sys.argv[5])
plt.plot(range(start,end), contentS, label='sequential')
plt.plot(range(start,end), contentR, label='random')
plt.plot(range(start,end), contentI, label='interleaving')
plt.xlabel('file size in block number')
plt.ylabel('read miss times')
plt.legend()
plt.title('read miss times over file size(cache size = 16,total read times: 10000')
plt.show()
plt.close()
